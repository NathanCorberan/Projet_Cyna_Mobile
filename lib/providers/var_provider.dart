import 'package:flutter/material.dart';
import 'dart:convert';

class User extends ChangeNotifier {
  int id;
  String first_name;
  String last_name;
  String email;
  String _userToken = '';

  String get userToken => _userToken;

  void updateUserToken(String token) {
    _userToken = token;
    notifyListeners();
  }

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
  });

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
    if (firstName != null && firstName != first_name) {
      first_name = firstName;
      changed = true;
    }
    if (lastName != null && lastName != last_name) {
      last_name = lastName;
      changed = true;
    }
    if (email != null && email != this.email) {
      this.email = email;
      changed = true;
    }
    if (changed) notifyListeners();
  }
}

class VarProvider extends ChangeNotifier {
  String _sharedVariable = "Valeur initiale";

  String get sharedVariable => _sharedVariable;

  void updateVariable(String newValue) {
    _sharedVariable = newValue;
    notifyListeners();
  }

  int? _orderId;
  int? get orderId => _orderId;

  void setOrderId(int id) {
    _orderId = id;
    notifyListeners();
  }

  void clearOrderId() {
    _orderId = null;
    notifyListeners();
  }

  final String url = "http://srv839278.hstgr.cloud:8000/api";

  User? _userVariable;

  User? get userVariable => _userVariable;

  void setUserVariableNull() {
    _userVariable = null;
    print(_userVariable);
    notifyListeners();
  }

  void updateUserVariable(Object newValue) {
    if (newValue is String) {
      try {
        newValue = jsonDecode(newValue);
      } catch (e) {
        print("Erreur lors du décodage JSON : $e");
        return;
      }
    }

    if (newValue is Map<String, dynamic>) {
      if (_userVariable == null) {
        _userVariable = User(
          id: newValue['id'] ?? 0,
          first_name: '',
          last_name: '',
          email: '',
        );
      }

      _userVariable!.updateInfo(
        userId: newValue['id'],
        firstName: newValue['first_name'],
        lastName: newValue['last_name'],
        email: newValue['email'],
      );

      if (newValue.containsKey('token')) {
        _userVariable!.updateUserToken(newValue['token']);
      }

      notifyListeners();
      print("Utilisateur mis à jour : ID=${_userVariable!.id}");
    } else {
      print("Erreur : données inattendues");
    }
  }
}
