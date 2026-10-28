import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/models/watch.dart';
import '../providers/watch_provider.dart';

const watchTypes = ['product', 'family', 'category', 'brand', 'coupon'];

class WatchCreateScreen extends StatefulWidget {
  const WatchCreateScreen({super.key});
  @override
  State<WatchCreateScreen> createState() => _WatchCreateScreenState();
}

class _WatchCreateScreenState extends State<WatchCreateScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _keywords = TextEditingController();
  final _target = TextEditingController();
  String _type = watchTypes.first;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _keywords.dispose();
    _target.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await context.read<WatchProvider>().create(
        Watch(
          id: 0,
          type: _type,
          name: _name.text.trim(),
          config: {
            'keywords': _keywords.text
                .split(',')
                .map((v) => v.trim())
                .where((v) => v.isNotEmpty)
                .toList(),
          },
          rules: _target.text.trim().isEmpty
              ? {'min_pct_below_30d': 10}
              : {
                  'max_price': double.parse(
                    _target.text.trim().replaceAll(',', '.'),
                  ),
                },
        ),
      );
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
      title: const Text('Create a watch'),
      leading: BackButton(onPressed: () => context.go('/watches')),
    ),
    body: Form(
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
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Name this watch' : null,
          ),
          TextFormField(
            controller: _keywords,
            decoration: const InputDecoration(
              labelText: 'Keywords, separated by commas',
              hintText: 'RTX 5070, RX 9070',
              helperText: 'An offer must contain at least one keyword.',
            ),
            validator: (v) =>
                v == null || v.split(',').every((s) => s.trim().isEmpty)
                ? 'Add a keyword'
                : null,
          ),
          TextFormField(
            controller: _target,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Target price in BRL (optional)',
              hintText: '2500,00',
              helperText: 'Without a target: 10% below the observed median, after seven days.',
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return null;
              final price = double.tryParse(v.trim().replaceAll(',', '.'));
              return price == null || !price.isFinite || price <= 0
                  ? 'Enter a positive price, for example 2500,00'
                  : null;
            },
          ),
          const SizedBox(height: 24),
          if (_error != null) Text(_error!),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Saving…' : 'Start watching'),
          ),
        ],
      ),
    ),
  );
}
