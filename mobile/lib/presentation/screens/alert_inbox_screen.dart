import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';

class AlertInboxScreen extends StatefulWidget {
  const AlertInboxScreen({super.key});
  @override
  State<AlertInboxScreen> createState() => _AlertInboxScreenState();
}

class _AlertInboxScreenState extends State<AlertInboxScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) context.read<AlertProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AlertProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts')),
      body: ap.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ap.alerts.length,
              itemBuilder: (ctx, i) {
                final a = ap.alerts[i];
                return ListTile(
                  title: Text(a.title),
                  subtitle: Text(a.body),
                  trailing: a.isRead ? null : IconButton(
                    icon: const Icon(Icons.mark_email_read),
                    onPressed: () => ap.markRead(a.id),
                  ),
                );
              },
            ),
    );
  }
}
