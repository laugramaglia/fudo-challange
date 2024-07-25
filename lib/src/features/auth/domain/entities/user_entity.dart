class UserEntity {
  final int id;
  final String email;
  final String password;
  final String name;

  const UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }

  @override
  String toString() =>
      'UserEntity(id: $id, email: $email, password: $password, name: $name)';
}
