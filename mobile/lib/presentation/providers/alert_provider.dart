import 'package:flutter/foundation.dart';

import '../../data/models/alert.dart';
import '../../data/repositories/alert_repository.dart';

class AlertProvider extends ChangeNotifier {
  AlertProvider(this._repo);
  final AlertRepository _repo;

  List<Alert> alerts = [];
  bool loading = false;
  String? error;
  final Set<String> busy = {};

  Future<void> load() async {
    if (loading) return;
    loading = true;
    error = null;
    alerts = [];
    notifyListeners();
    try {
      alerts = await _repo.list();
    } catch (_) {
      error = 'Could not load your alerts. Pull down to try again.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> markRead(String id) async {
    if (!busy.add(id)) return;
    error = null;
    notifyListeners();
    try {
      await _repo.markRead(id);
      alerts = alerts
          .map(
            (a) => a.id == id
                ? Alert(
                    id: a.id,
                    title: a.title,
                    body: a.body,
                    readAt: DateTime.now(),
                  )
                : a,
          )
          .toList();
    } catch (_) {
      error = 'Could not mark this alert as read. Please try again.';
    } finally {
      busy.remove(id);
      notifyListeners();
    }
  }
}
