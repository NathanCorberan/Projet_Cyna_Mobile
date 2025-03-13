import 'package:flutter/material.dart';

class VarProvider extends ChangeNotifier {
  String _sharedVariable = "Valeur initiale";

  String get sharedVariable => _sharedVariable;

  void updateVariable(String newValue) {
    _sharedVariable = newValue;
    notifyListeners();
  }


}
