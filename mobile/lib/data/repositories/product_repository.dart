import '../../core/api_client.dart';
import '../models/price_point.dart';

class ProductRepository {
  ProductRepository(this._api);
  final ApiClient _api;

  Future<List<PricePoint>> priceHistory(int productId) async {
    final res = await _api.get('/api/v1/products/$productId/prices');
    final data = (res['data'] as List).cast<Map<String, dynamic>>();
    return data.map(PricePoint.fromJson).toList();
  }
}
