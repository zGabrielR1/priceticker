import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/watch_provider.dart';
import '../providers/auth_provider.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) context.read<WatchProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WatchProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watches'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await context.read<AuthProvider>().logout();
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Signed out locally. Server revocation could not be confirmed.',
                      ),
                    ),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.radar),
            tooltip: 'Deals',
            onPressed: () => context.go('/deals'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.go('/alerts'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: wp.load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            if (wp.loading) const LinearProgressIndicator(),
            if (wp.error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(wp.error!),
                ),
              ),
            if (!wp.loading && wp.error == null && wp.watches.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No watches yet. Add keywords and a target price to start your radar.',
                ),
              ),
            for (final w in wp.watches)
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(w.name)),
                          IconButton(
                            tooltip: 'Edit watch',
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: wp.busy.contains(w.id)
                                ? null
                                : () => context.go('/watches/${w.id}/edit'),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '${w.isActive ? 'Watching' : 'Paused'} · ${w.type}',
                      ),
                      value: w.isActive,
                      onChanged: wp.busy.contains(w.id)
                          ? null
                          : (active) => wp.setActive(w, active),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (w.config['keywords'] as List<dynamic>? ?? []).join(
                            ', ',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Delete'),
                        onPressed: wp.busy.contains(w.id)
                            ? null
                            : () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Delete watch?'),
                                    content: Text(
                                      'Remove "${w.name}" and its deal matches?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed == true) await wp.remove(w.id);
                              },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/watches/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
