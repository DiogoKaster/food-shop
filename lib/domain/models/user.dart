class User {
  final int? id;
  final String name;
  final String email;
  final String document;
  final String password;
  final String? profileImage; //adicionado
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.password,
    this.profileImage, //adicionado
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? document,
    String? password,
    String? profileImage, //adicionado
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      document: document ?? this.document,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage, //adicionado
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
