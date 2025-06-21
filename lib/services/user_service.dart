// lib/services/user_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:findlab/models/user.dart';

class UserService {
  static const String _usersKey = 'users';

  // Save a user to shared_preferences
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> usersJson = prefs.getStringList(_usersKey) ?? [];
    usersJson.add(jsonEncode(user.toJson()));
    await prefs.setStringList(_usersKey, usersJson);
  }

  // Retrieve all users
  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> usersJson = prefs.getStringList(_usersKey) ?? [];
    return usersJson.map((json) => User.fromJson(jsonDecode(json))).toList();
  }

  // Find a user by email and password
  Future<User?> findUser(String email, String password) async {
    final users = await getUsers();
    try {
      return users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }
}
