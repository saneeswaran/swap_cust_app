import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/constants.dart';
import '../../../../../models/user/user_model.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  UserModel? _user;

  String? get token => _token;
  UserModel? get user => _user;

  // Register User
  Future<bool> registerUser(UserModel user) async {
    final url = Uri.parse("$baseUrl/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toMap()),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['success']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return false;
    }
  }

  // Login User
  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['success']) {
        _token = data['token'];
        _user = UserModel.fromMap(data['user']);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return false;
    }
  }

  // Logout User
  void logoutUser() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}
