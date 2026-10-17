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
  final _name = TextEditingController();
  String _type = watchTypes.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Watch')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _type,
              items: watchTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _type = v ?? _type),
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final w = Watch(id: 0, type: _type, name: _name.text);
                await context.read<WatchProvider>().create(w);
                if (context.mounted) context.go('/watches');
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
