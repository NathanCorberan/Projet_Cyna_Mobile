import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/var_provider.dart';
import '../models/product.dart';

class GetProduct {
  static Future<Product> fetchProductById(BuildContext context, int productId) async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final String url = '${varProvider.url}/products/$productId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Product.fromJson(jsonResponse);
      } else {
        throw Exception('Erreur serveur : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }

  static Future<List<Product>> fetchTopProduct(BuildContext context) async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final String url = '${varProvider.url}/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('member') && jsonResponse['member'] != null) {
          List<dynamic> products = jsonResponse['member'];
          return products.map((item) => Product.fromJson(item)).toList();
        } else {
          throw Exception('Clé "member" manquante ou nulle.');
        }
      } else {
        throw Exception('Erreur serveur : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }
}
