class ProductModel {
  final String id;
  final String sellerId;
  final String title;
  final String? description;
  final double price;
  final String? category;
  final List<String> images;
  final String status;

  ProductModel({
    required this.id,
    required this.sellerId,
    required this.title,
    this.description,
    required this.price,
    this.category,
    required this.images,
    required this.status,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      sellerId: json['seller_id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images']),
      status: json['status'],
      description: json['description'],
      category: json['category'],
    );
  }
}
