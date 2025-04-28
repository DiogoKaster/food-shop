class Product {
  final int? id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  Product copyWith({
    int? id,
    int? restaurantId,
    String? name,
    String? description,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
