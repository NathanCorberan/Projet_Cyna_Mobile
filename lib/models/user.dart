import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  String email;
  String _userToken = '';

  String get userToken => _userToken;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  void updateUserToken(String token) {
    _userToken = token;
    notifyListeners();
  }

  void updateInfo({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    bool changed = false;

    if (userId != null && userId != id) {
      id = userId;
      changed = true;
    }

    if (firstName != null && firstName != this.firstName) {
      this.firstName = firstName;
      changed = true;
    }

    if (lastName != null && lastName != this.lastName) {
      this.lastName = lastName;
      changed = true;
    }

    if (email != null && email != this.email) {
      this.email = email;
      changed = true;
    }

    if (changed) notifyListeners();
  }
}
