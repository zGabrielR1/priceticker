import 'package:flutter/foundation.dart';

import '../../data/models/watch.dart';
import '../../data/repositories/watch_repository.dart';

class WatchProvider extends ChangeNotifier {
  WatchProvider(this._repo);
  final WatchRepository _repo;

  List<Watch> watches = [];
  bool loading = false;
  String? error;
  final Set<int> busy = {};

  Future<void> load() async {
    if (loading) return;
    loading = true;
    error = null;
    watches = [];
    notifyListeners();
    try {
      watches = await _repo.list();
    } catch (_) {
      error = 'Could not load your watches. Pull down to try again.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> create(Watch w) async {
    final created = await _repo.create(w);
    watches = [...watches, created];
    notifyListeners();
  }

  Future<void> setActive(Watch watch, bool active) async {
    if (!busy.add(watch.id)) return;
    error = null;
    notifyListeners();
    try {
      final updated = await _repo.setActive(watch.id, active);
      watches = watches.map((w) => w.id == updated.id ? updated : w).toList();
    } catch (_) {
      error = 'Could not update this watch. Please try again.';
    } finally {
      busy.remove(watch.id);
      notifyListeners();
    }
  }

  Future<void> remove(int id) async {
    if (!busy.add(id)) return;
    error = null;
    notifyListeners();
    try {
      await _repo.delete(id);
      watches = watches.where((w) => w.id != id).toList();
    } catch (_) {
      error = 'Could not delete this watch. Please try again.';
    } finally {
      busy.remove(id);
      notifyListeners();
    }
  }
}
