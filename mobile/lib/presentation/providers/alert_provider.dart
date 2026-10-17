import 'package:flutter/foundation.dart';
import '../../data/models/alert.dart';
import '../../data/repositories/alert_repository.dart';

class AlertProvider extends ChangeNotifier {
  AlertProvider(this._repo);
  final AlertRepository _repo;

  List<Alert> alerts = [];
  bool loading = false;

  Future<void> load() async {
    loading = true;
    notifyListeners();
    try {
      alerts = await _repo.list();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> markRead(String id) async {
    await _repo.markRead(id);
    final i = alerts.indexWhere((a) => a.id == id);
    if (i >= 0) {
      alerts[i] = Alert(id: alerts[i].id, title: alerts[i].title, body: alerts[i].body, readAt: DateTime.now());
      notifyListeners();
    }
  }
}
