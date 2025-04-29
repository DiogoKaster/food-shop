class Restaurant {
  final int? id;
  final String cnpj;
  final String name;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final String complement;
  final String? brand;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Restaurant({
    this.id,
    required this.cnpj,
    required this.name,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.complement,
    this.brand,
    this.createdAt,
    this.updatedAt,
  });

  Restaurant copyWith({
    int? id,
    String? cnpj,
    String? name,
    String? street,
    String? number,
    String? neighborhood,
    String? city,
    String? state,
    String? zipCode,
    String? complement,
    String? brand,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Restaurant(
      id: id ?? this.id,
      cnpj: cnpj ?? this.cnpj,
      name: name ?? this.name,
      street: street ?? this.street,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      complement: complement ?? this.complement,
      brand: brand ?? this.brand,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
