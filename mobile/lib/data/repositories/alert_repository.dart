import '../../core/api_client.dart';
import '../models/alert.dart';

class AlertRepository {
  AlertRepository(this._api);
  final ApiClient _api;

  Future<List<Alert>> list() async {
    final res = await _api.get('/api/v1/alerts');
    final data = (res['data'] as List).cast<Map<String, dynamic>>();
    return data.map(Alert.fromJson).toList();
  }

  Future<void> markRead(String id) async {
    await _api.post('/api/v1/alerts/$id/read');
  }
}
