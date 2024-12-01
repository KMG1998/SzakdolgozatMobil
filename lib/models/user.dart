class User {
  String name;
  final String email;

  User({required this.email, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      email: json["email"],
    );
  }
}
