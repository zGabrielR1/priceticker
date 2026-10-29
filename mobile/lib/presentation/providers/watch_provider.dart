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

  int _generation = 0;
  bool _disposed = false;

  void reset() {
    _generation++;
    watches = [];
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
    watches = [];
    notifyListeners();
    try {
      final result = await _repo.list();
      if (_disposed || generation != _generation) return;
      watches = result;
    } catch (_) {
      if (_disposed || generation != _generation) return;
      error = 'Could not load your watches. Pull down to try again.';
    } finally {
      if (!_disposed && generation == _generation) {
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> create(Watch w) async {
    final generation = _generation;
    final created = await _repo.create(w);
    if (_disposed || generation != _generation) return;
    watches = [...watches, created];
    notifyListeners();
  }

  Future<void> update(Watch watch) async {
    final generation = _generation;
    final updated = await _repo.update(watch);
    if (_disposed || generation != _generation) return;
    watches = watches.map((w) => w.id == updated.id ? updated : w).toList();
    notifyListeners();
  }

  Future<void> setActive(Watch watch, bool active) async {
    final generation = _generation;
    if (!busy.add(watch.id)) return;
    error = null;
    notifyListeners();
    try {
      final updated = await _repo.setActive(watch.id, active);
      if (_disposed || generation != _generation) return;
      watches = watches.map((w) => w.id == updated.id ? updated : w).toList();
    } catch (_) {
      if (_disposed || generation != _generation) return;
      error = 'Could not update this watch. Please try again.';
    } finally {
      if (!_disposed && generation == _generation) {
        busy.remove(watch.id);
        notifyListeners();
      }
    }
  }

  Future<void> remove(int id) async {
    final generation = _generation;
    if (!busy.add(id)) return;
    error = null;
    notifyListeners();
    try {
      await _repo.delete(id);
      if (_disposed || generation != _generation) return;
      watches = watches.where((w) => w.id != id).toList();
    } catch (_) {
      if (_disposed || generation != _generation) return;
      error = 'Could not delete this watch. Please try again.';
    } finally {
      if (!_disposed && generation == _generation) {
        busy.remove(id);
        notifyListeners();
      }
    }
  }
}
