import '../../core/api_client.dart';
import '../models/watch.dart';

class WatchRepository {
  WatchRepository(this._api);
  final ApiClient _api;

  Future<List<Watch>> list() async {
    final res = await _api.get('/api/v1/watches');
    final data = (res['data'] as List).cast<Map<String, dynamic>>();
    return data.map(Watch.fromJson).toList();
  }

  Future<Watch> create(Watch w) async {
    final res = await _api.post('/api/v1/watches', body: w.toJson());
    return Watch.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<Watch> get(int id) async {
    final res = await _api.get('/api/v1/watches/$id');
    return Watch.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<Watch> update(Watch watch) async {
    final res = await _api.put(
      '/api/v1/watches/${watch.id}',
      body: watch.toJson(),
    );
    return Watch.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<Watch> setActive(int id, bool active) async {
    final res = await _api.put(
      '/api/v1/watches/$id',
      body: {'is_active': active},
    );
    return Watch.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _api.delete('/api/v1/watches/$id');
  }
}
