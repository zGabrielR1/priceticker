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

  int _generation = 0;
  bool _disposed = false;

  void reset() {
    _generation++;
    alerts = [];
    error = null;
    loading = false;
    busy.clear();
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    super.dispose();
  }

  Future<void> load() async {
    if (loading) return;
    final generation = _generation;
    loading = true;
    error = null;
    alerts = [];
    notifyListeners();
    try {
      final result = await _repo.list();
      if (_disposed || generation != _generation) return;
      alerts = result;
    } catch (_) {
      if (_disposed || generation != _generation) return;
      error = 'Could not load your alerts. Pull down to try again.';
    } finally {
      if (!_disposed && generation == _generation) {
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> markRead(String id) async {
    final generation = _generation;
    if (!busy.add(id)) return;
    error = null;
    notifyListeners();
    try {
      await _repo.markRead(id);
      if (_disposed || generation != _generation) return;
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
      if (_disposed || generation != _generation) return;
      error = 'Could not mark this alert as read. Please try again.';
    } finally {
      if (!_disposed && generation == _generation) {
        busy.remove(id);
        notifyListeners();
      }
    }
  }
}
