class User {
  final int? id;
  final String name;
  final String email;
  final String document;
  final String password;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? cep;
  final String? street;
  final String? number;
  final String? complement;
  final String? neighborhood;
  final String? city;
  final String? state;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.password,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.cep,
    this.street,
    this.number,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? document,
    String? password,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? cep,
    String? street,
    String? number,
    String? complement,
    String? neighborhood,
    String? city,
    String? state,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      document: document ?? this.document,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cep: cep ?? this.cep,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}
