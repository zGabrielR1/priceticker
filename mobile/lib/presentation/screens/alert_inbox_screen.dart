import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        title: const Text('Alerts'),
        leading: BackButton(onPressed: () => context.go('/deals')),
      ),
      body: RefreshIndicator(
        onRefresh: ap.load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            if (ap.loading) const LinearProgressIndicator(),
            if (ap.error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(ap.error!),
                ),
              ),
            if (!ap.loading && ap.error == null && ap.alerts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No alerts yet. Your next matching deal will appear here.',
                ),
              ),
            for (final a in ap.alerts)
              Card(
                child: ListTile(
                  leading: Icon(
                    a.isRead
                        ? Icons.notifications_none
                        : Icons.notifications_active_outlined,
                  ),
                  title: Text(a.title),
                  subtitle: Text(a.body),
                  trailing: a.isRead
                      ? null
                      : IconButton(
                          tooltip: 'Mark as read',
                          icon: const Icon(Icons.mark_email_read_outlined),
                          onPressed: ap.busy.contains(a.id)
                              ? null
                              : () => ap.markRead(a.id),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
