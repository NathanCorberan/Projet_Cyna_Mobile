import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class User {
  String first_name;
  String last_name;
  String email;

  User({required this.first_name, required this.last_name, required this.email});
}

class VarProvider extends ChangeNotifier {
  String _sharedVariable = "Valeur initiale";

  String get sharedVariable => _sharedVariable;

  void updateVariable(String newValue) {
    _sharedVariable = newValue;
    notifyListeners();
  }

  User? _userVariable;

  User? get userVariable => _userVariable;

  void updateUserVariable(Object newValue) {
    print("Type de newValue: ${newValue.runtimeType}");
    print("Valeur de newValue: $newValue");

    if (newValue is String) {
      try {
        newValue = jsonDecode(newValue);
      } catch (e) {
        print(" Erreur lors du décodage JSON : $e");
        return;
      }
    }

    // Vérification que newValue est bien un Map<String, dynamic>
    if (newValue is Map<String, dynamic>) {
      _userVariable ??= User(first_name: '', last_name: '', email: '');

      _userVariable!.email = newValue['email'] ?? _userVariable!.email;
      _userVariable!.first_name = newValue['first_name'] ?? _userVariable!.first_name;
      _userVariable!.last_name = newValue['last_name'] ?? _userVariable!.last_name;

      notifyListeners();
      print("✅ Utilisateur mis à jour : $_userVariable");
    } else {
      print("Erreur");
    }
  }

}