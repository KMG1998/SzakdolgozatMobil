class User {
  final String? id;
  String name;
  final int typeId;
  final String email;

  User(
      {required this.typeId, required this.email, required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      typeId: json["typeId"],
      email: json["email"],
    );
  }
}