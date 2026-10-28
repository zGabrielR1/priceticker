import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/watch_provider.dart';

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
      body: wp.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wp.watches.length,
              itemBuilder: (ctx, i) {
                final w = wp.watches[i];
                return ListTile(
                  title: Text(w.name),
                  subtitle: Text(w.type),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => wp.remove(w.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/watches/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
