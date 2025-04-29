class Order {
  final int? id;
  final int userId;
  final int userAddressId;
  final String deliveryType;
  final String status;
  final double totalPrice;
  final DateTime? paidAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    required this.userId,
    required this.userAddressId,
    required this.deliveryType,
    required this.status,
    required this.totalPrice,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
  });

  Order copyWith({
    int? id,
    int? userId,
    int? userAddressId,
    String? deliveryType,
    String? status,
    double? totalPrice,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userAddressId: userAddressId ?? this.userAddressId,
      deliveryType: deliveryType ?? this.deliveryType,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
