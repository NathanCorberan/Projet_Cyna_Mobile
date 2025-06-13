import 'package:flutter/material.dart';
import 'dart:convert';

/// Classe représentant un utilisateur
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

  /// Met à jour le token utilisateur
  void updateUserToken(String token) {
    _userToken = token;
    notifyListeners();
  }

  /// Met à jour les informations de l'utilisateur
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

/// Provider principal pour les variables partagées
class VarProvider extends ChangeNotifier {
  //==================================================
  // URL de base de l'API
  //==================================================
  final String url = "http://srv839278.hstgr.cloud:8000/api";

  //==================================================
  // Variable partagée simple
  //==================================================
  String _sharedVariable = "Valeur initiale";
  String get sharedVariable => _sharedVariable;

  void updateVariable(String newValue) {
    _sharedVariable = newValue;
    notifyListeners();
  }

  //==================================================
  // Gestion des commandes
  //==================================================
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

  //==================================================
  // Gestion des données utilisateur
  //==================================================
  User? _userVariable;
  User? get userVariable => _userVariable;

  void setUserVariableNull() {
    _userVariable = null;
    notifyListeners();
  }

  void updateUserVariable(Object newValue) {
    // Décodage si c'est une chaîne JSON
    if (newValue is String) {
      try {
        newValue = jsonDecode(newValue);
      } catch (e) {
        print("Erreur lors du décodage JSON : $e");
        return;
      }
    }

    if (newValue is Map<String, dynamic>) {
      // Création si l'utilisateur n'existe pas encore
      _userVariable ??= User(
        id: newValue['id'] ?? 0,
        firstName: '',
        lastName: '',
        email: '',
      );

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

  //==================================================
  // Gestion des URL d'images
  //==================================================
  String? _categorieImageUrl = "http://srv839278.hstgr.cloud:8000/assets/images/categories/";
  String? get categorieImageUrl => _categorieImageUrl;

  void updateCategorieImageUrl(String url) {
    _categorieImageUrl = url;
    notifyListeners();
  }

  String? _productImageUrl = "http://srv839278.hstgr.cloud:8000/assets/images/products/";
  String? get productImageUrl => _productImageUrl;

  void updateProductImageUrl(String url) {
    _productImageUrl = url;
    notifyListeners();
  }
}
