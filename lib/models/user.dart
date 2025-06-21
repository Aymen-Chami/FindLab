enum UserRole { patient, clinic }

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: UserRole.values.firstWhere(
        (role) => role.toString().split('.').last == json['role'],
      ),
    );
  }
}
