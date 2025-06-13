import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';

class VarProvider extends ChangeNotifier {
  final String url = "http://srv839278.hstgr.cloud:8000/api";

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

  User? _userVariable;
  User? get userVariable => _userVariable;

  void setUserVariableNull() {
    _userVariable = null;
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
