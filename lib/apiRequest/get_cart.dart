import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/var_provider.dart';

class CartService {
  String? _cartToken;

  Future<String?> _loadCartToken() async {
    final prefs = await SharedPreferences.getInstance();
    _cartToken = prefs.getString('cartToken');
    return _cartToken;
  }

  Future<void> _saveCartToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cartToken', token);
    _cartToken = token;
  }

  Future<List<CartItem>> fetchCart(BuildContext context) async {
    await _loadCartToken();
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final url = '${varProvider.url}/cart';

    final response = await http.get(
      Uri.parse(url),
      headers: _cartToken != null ? {'X-Cart-Token': _cartToken!} : {},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CartItem.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> ensureCartToken(Map<String, dynamic> jsonData) async {
    if (_cartToken == null && jsonData['order'] != null) {
      final token = jsonData['order']['cartToken'];
      await _saveCartToken(token);
    }
  }

  String? get cartToken => _cartToken;
}
