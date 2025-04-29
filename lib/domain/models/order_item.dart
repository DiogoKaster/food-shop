class OrderItem {
  final int? id;
  final int orderId;
  final int productId;
  final int quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderItem({
    this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  OrderItem copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    double? unitPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
