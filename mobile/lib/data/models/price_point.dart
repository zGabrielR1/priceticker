class PricePoint {
  PricePoint({required this.price, required this.createdAt});
  final double price;
  final DateTime createdAt;

  factory PricePoint.fromJson(Map<String, dynamic> j) => PricePoint(
        price: (j['price'] as num).toDouble(),
        createdAt: DateTime.parse(j['created_at'] as String),
      );
}
