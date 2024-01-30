class User {
  final String id;
  String name;
  final int typeId;
  final String email;
  String password;
  final String salt;

  User(
      {required this.password, required this.typeId, required this.email, required this.salt, required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      typeId: json["typeId"],
      email: json["email"],
      password: json["password"],
      salt: json["salt"],
    );
  }
}