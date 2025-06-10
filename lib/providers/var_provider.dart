import 'package:flutter/material.dart';
import 'dart:convert';

class User extends ChangeNotifier {
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
    required this.first_name,
    required this.last_name,
    required this.email,
  });

  // Méthodes pour mettre à jour les champs en notifiant
  void updateInfo({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    bool changed = false;
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
        _userVariable = User(first_name: '', last_name: '', email: '');
      }

      _userVariable!.updateInfo(
        firstName: newValue['first_name'],
        lastName: newValue['last_name'],
        email: newValue['email'],
      );

      // ✅ Ajoute le token ici
      if (newValue.containsKey('token')) {
        _userVariable!.updateUserToken(newValue['token']);
      }

      notifyListeners();
      print("Utilisateur mis à jour : $_userVariable");
    } else {
      print("Erreur : données inattendues");
    }
  }
}
