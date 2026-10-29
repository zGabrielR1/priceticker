import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/models/watch.dart';
import '../../core/api_client.dart';
import '../../data/repositories/watch_repository.dart';
import '../providers/watch_provider.dart';

const watchTypes = ['product', 'family', 'category', 'brand', 'coupon'];

class WatchCreateScreen extends StatefulWidget {
  const WatchCreateScreen({super.key, this.watchId});
  final int? watchId;
  @override
  State<WatchCreateScreen> createState() => _WatchCreateScreenState();
}

class _WatchCreateScreenState extends State<WatchCreateScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _keywords = TextEditingController();
  final _target = TextEditingController();
  final _excluded = TextEditingController();
  bool _matchAll = false;
  List<dynamic> _sources = [];
  final Set<String> _stores = {};
  bool _sourceError = false;
  String _type = watchTypes.first;
  bool _saving = false;
  String? _error;
  Watch? _original;
  bool _loadingWatch = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadSources();
    if (widget.watchId != null) _loadWatch();
  }

  Future<void> _loadWatch() async {
    setState(() {
      _loadingWatch = true;
      _loadError = null;
    });
    try {
      final watch = await context.read<WatchRepository>().get(widget.watchId!);
      if (!mounted) return;
      setState(() {
        _original = watch;
        _name.text = watch.name;
        _type = watch.type;
        _keywords.text = (watch.config['keywords'] as List<dynamic>? ?? [])
            .join(', ');
        _excluded.text =
            (watch.config['exclude_keywords'] as List<dynamic>? ?? []).join(
              ', ',
            );
        _matchAll = watch.config['keyword_mode'] == 'all';
        _target.text = watch.rules['max_price']?.toString() ?? '';
        _stores.addAll(
          (watch.rules['store_allowlist'] as List<dynamic>? ?? [])
              .cast<String>(),
        );
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loadError = 'Could not load this watch. It may have been removed or your connection is unavailable.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loadingWatch = false;
        });
      }
    }
  }

  Future<void> _loadSources() async {
    try {
      final result = await context.read<ApiClient>().get(
        '/api/v1/discovery/sources',
      );
      if (mounted) {
        setState(() {
          _sources = result['data'] as List<dynamic>;
          _sourceError = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _sourceError = true;
        });
      }
    }
  }

  List<String> _terms(String text) => text
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toSet()
      .toList();

  @override
  void dispose() {
    _name.dispose();
    _keywords.dispose();
    _target.dispose();
    _excluded.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final original = _original;
      final rules = Map<String, dynamic>.from(original?.rules ?? {});
      rules['max_price'] = _target.text.trim().isEmpty
          ? null
          : double.parse(_target.text.trim().replaceAll(',', '.'));
      rules['store_allowlist'] = _stores.toList();
      if (_target.text.trim().isEmpty && rules['min_pct_below_30d'] == null) {
        rules['min_pct_below_30d'] = 10;
      }
      final watch = Watch(
        id: original?.id ?? 0,
        type: _type,
        name: _name.text.trim(),
        isActive: original?.isActive ?? true,
        config: {
          ...?original?.config,
          'keywords': _terms(_keywords.text),
          'keyword_mode': _matchAll ? 'all' : 'any',
          'exclude_keywords': _terms(_excluded.text),
        },
        rules: rules,
      );
      final provider = context.read<WatchProvider>();
      if (original == null) {
        await provider.create(watch);
      } else {
        await provider.update(watch);
      }
      if (mounted) context.go('/watches');
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'Could not save your watch. Please try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.watchId == null ? 'Create a watch' : 'Edit watch'),
      leading: BackButton(onPressed: () => context.go('/watches')),
    ),
    body: _loadingWatch
        ? const Center(child: CircularProgressIndicator())
        : _loadError != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_loadError!),
                  TextButton(onPressed: _loadWatch, child: const Text('Retry')),
                ],
              ),
            ),
          )
        : Form(
            key: _form,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Tell your radar what a good deal looks like.'),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  items: watchTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() {
                    _type = v ?? _type;
                  }),
                  decoration: const InputDecoration(labelText: 'Watch type'),
                ),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'My next graphics card',
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Name this watch'
                      : v.trim().length > 255
                      ? 'Use at most 255 characters'
                      : null,
                ),
                TextFormField(
                  controller: _keywords,
                  decoration: InputDecoration(
                    labelText: 'Keywords, separated by commas',
                    hintText: 'RTX 5070, RX 9070',
                    helperText: _matchAll
                        ? 'Every keyword must appear in the title.'
                        : 'At least one keyword must appear in the title.',
                  ),
                  validator: (v) {
                    final terms = _terms(v ?? '');
                    if (terms.isEmpty &&
                        (_original?.config['keywords'] as List<dynamic>? ??
                                ['required'])
                            .isNotEmpty) {
                      return 'Add a keyword';
                    }
                    return terms.length > 20 || terms.any((s) => s.length > 120)
                        ? 'Use up to 20 keywords, each at most 120 characters'
                        : null;
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Require every keyword'),
                  subtitle: Text(
                    _matchAll
                        ? 'All listed terms must appear in the title.'
                        : 'Any listed term can match.',
                  ),
                  value: _matchAll,
                  onChanged: _saving
                      ? null
                      : (value) => setState(() {
                          _matchAll = value;
                        }),
                ),
                TextFormField(
                  controller: _excluded,
                  decoration: const InputDecoration(
                    labelText: 'Exclude terms (optional)',
                    hintText: 'used, open box',
                    helperText: 'Skip offers containing any of these terms.',
                  ),
                  validator: (v) =>
                      _terms(v ?? '').length > 20 ||
                          _terms(v ?? '').any((s) => s.length > 120)
                      ? 'Use up to 20 terms, each at most 120 characters'
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  'Preferred stores',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Text(
                  'Leave all stores unselected to watch every configured source.',
                ),
                if (_sourceError)
                  TextButton(
                    onPressed: _loadSources,
                    child: const Text('Could not load stores. Retry'),
                  ),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final missing in _stores.where(
                      (id) => !_sources.any((source) => source['id'] == id),
                    ))
                      InputChip(
                        label: Text('$missing (unavailable)'),
                        onDeleted: _saving
                            ? null
                            : () => setState(() {
                                _stores.remove(missing);
                              }),
                      ),
                    for (final source in _sources)
                      FilterChip(
                        label: Text(source['name'] as String),
                        selected: _stores.contains(source['id']),
                        onSelected: _saving
                            ? null
                            : (selected) => setState(() {
                                if (selected) {
                                  _stores.add(source['id'] as String);
                                } else {
                                  _stores.remove(source['id']);
                                }
                              }),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _target,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Target price in BRL (optional)',
                    hintText: '2500,00',
                    helperText: widget.watchId == null
                        ? 'Without a target: 10% below the observed median, after seven days.'
                        : 'Existing history and alert rules are preserved.',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final price = double.tryParse(
                      v.trim().replaceAll(',', '.'),
                    );
                    return price == null ||
                            !price.isFinite ||
                            price <= 0 ||
                            price > 9999999999.99
                        ? 'Enter a positive price, for example 2500,00'
                        : null;
                  },
                ),
                const SizedBox(height: 24),
                if (_error != null) Text(_error!),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(
                    _saving
                        ? 'Saving…'
                        : widget.watchId == null
                        ? 'Start watching'
                        : 'Save changes',
                  ),
                ),
              ],
            ),
          ),
  );
}
