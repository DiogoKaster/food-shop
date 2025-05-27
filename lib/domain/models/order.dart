enum DeliveryType { standard, express }

enum OrderStatus { preparing, inDelivery, delivered, cancelled }

class Order {
  final int? id;
  final int userId;
  final int restaurantId;
  final int? userAddressId;
  final DeliveryType deliveryType;
  final OrderStatus status;
  final double totalPrice;
  final DateTime? paidAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    required this.userId,
    required this.restaurantId,
    this.userAddressId,
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
    int? restaurantId,
    int? userAddressId,
    DeliveryType? deliveryType,
    OrderStatus? status,
    double? totalPrice,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
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
