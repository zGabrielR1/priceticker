import 'package:flutter/foundation.dart';
import '../../data/models/watch.dart';
import '../../data/repositories/watch_repository.dart';

class WatchProvider extends ChangeNotifier {
  WatchProvider(this._repo);
  final WatchRepository _repo;

  List<Watch> watches = [];
  bool loading = false;

  Future<void> load() async {
    loading = true;
    notifyListeners();
    try {
      watches = await _repo.list();
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

  Future<void> remove(int id) async {
    await _repo.delete(id);
    watches = watches.where((w) => w.id != id).toList();
    notifyListeners();
  }
}
