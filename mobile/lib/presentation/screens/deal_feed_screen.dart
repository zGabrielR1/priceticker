import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api_client.dart';

class DealFeedScreen extends StatefulWidget {
  const DealFeedScreen({super.key});

  @override
  State<DealFeedScreen> createState() => _DealFeedScreenState();
}

class _DealFeedScreenState extends State<DealFeedScreen> {
  List<dynamic> _deals = [];
  List<dynamic> _sources = [];
  bool _loading = true;
  String? _error;
  String _search = '';
  String? _source;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!_loading &&
          WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        _load();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final api = context.read<ApiClient>();
      final result = await Future.wait([
        api.get('/api/v1/deals'),
        api.get('/api/v1/discovery/sources'),
      ]);
      if (!mounted) return;
      setState(() {
        _deals = result[0]['data'] as List<dynamic>;
        _sources = result[1]['data'] as List<dynamic>;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error =
            'Could not refresh deals. Check your connection and try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fresh = _deals.where((d) {
      final expiry = DateTime.tryParse(d['expires_at'] as String? ?? '');
      return expiry != null && expiry.isAfter(DateTime.now());
    });
    final deals = fresh
        .where(
          (d) =>
              (d['title'] as String).toLowerCase().contains(
                _search.toLowerCase(),
              ) &&
              (_source == null || d['source'] == _source),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your deal radar'),
        actions: [
          IconButton(
            onPressed: _loading ? null : _load,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Good prices. Direct from the store.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Offers matched to your watches. Prices can change; confirm availability and shipping at checkout.',
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (v) => setState(() {
                _search = v;
              }),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Find a product',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All stores'),
                  selected: _source == null,
                  onSelected: (_) => setState(() {
                    _source = null;
                  }),
                ),
                for (final s in _sources)
                  ChoiceChip(
                    label: Text(s['name'] as String),
                    selected: _source == s['id'],
                    onSelected: (_) => setState(() {
                      _source = s['id'] as String;
                    }),
                  ),
              ],
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (_error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(_error!),
                      TextButton(
                        onPressed: _load,
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              ),
            if (!_loading && _error == null && deals.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.radar, size: 48),
                      const SizedBox(height: 12),
                      const Text('Waiting for a price worth your attention.'),
                      const SizedBox(height: 8),
                      Text(
                        _sources.isEmpty
                            ? 'No retailer sources are configured on this server yet.'
                            : 'Add keywords and a target price to a watch. Historical discounts need at least seven days of observations.',
                      ),
                      TextButton(
                        onPressed: () => context.go('/watches/create'),
                        child: const Text('Create a watch'),
                      ),
                    ],
                  ),
                ),
              ),
            for (final d in deals)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${d['source']} · ${d['watch_name']}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        d['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'R\$ ${double.parse('${d['price']}').toStringAsFixed(2).replaceAll('.', ',')}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(d['reason'] as String),
                      Text('Store check: ${d['observed_at']}'),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open store'),
                        onPressed: () async {
                          final uri = Uri.tryParse(d['url'] as String);
                          final opened =
                              uri != null &&
                              uri.scheme == 'https' &&
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                          if (!opened && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open the store.'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            if (_sources.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Source health',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              for (final s in _sources)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    s['status']?['healthy'] == true
                        ? Icons.check_circle_outline
                        : Icons.schedule,
                  ),
                  title: Text(s['name'] as String),
                  subtitle: Text(
                    s['status'] == null
                        ? 'Waiting for first check'
                        : s['status']['healthy'] == true
                        ? 'Last successful check: ${s['status']['checked_at']}'
                        : 'Last check failed; retrying with backoff',
                  ),
                ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.go('/watches');
          if (i == 2) context.go('/alerts');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.radar), label: 'Deals'),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'Watches',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}
