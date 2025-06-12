import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/var_provider.dart';
import '../models/product.dart';

class GetProductByCategorie {
  static Future<List<Product>> fetchProductsByCategorie(BuildContext context, int categoryId) async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final url = '${varProvider.url}/categorie/$categoryId/products?page=1';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }

      final data = json.decode(response.body);

      if (!data.containsKey('member')) {
        throw Exception('La clé "member" est absente dans la réponse');
      }

      List productsRaw = data['member'];

      List<Product> products = [];

      for (var item in productsRaw) {
        products.add(Product.fromJson(item)); // ✅ Conversion avec modèle centralisé
      }

      return products;
    } catch (e) {
      throw Exception('Erreur lors du chargement des produits: $e');
    }
  }
}
