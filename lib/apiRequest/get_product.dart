import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/var_provider.dart';

class GetTopProduct {
  static Future<List<Map<String, String>>> fetchTopProduct(BuildContext context) async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final String url = '${varProvider.url}/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('member')) {
          List<dynamic> products = jsonResponse['member'];

          List<Map<String, String>> productList = products.map((item) {
            String name = item['productLangages'] != null && item['productLangages'].isNotEmpty
                ? item['productLangages'][0]['name'] ?? 'Nom indisponible'
                : 'Nom indisponible';

            String description = item['productLangages'] != null && item['productLangages'].isNotEmpty
                ? item['productLangages'][0]['description'] ?? 'Description indisponible'
                : 'Description indisponible';

            String image = item['productImages'] != null && item['productImages'].isNotEmpty
                ? item['productImages'][0]['image_link'] ?? ''
                : '';

            return {
              'name': name,
              'description': description,
              'image': image,
              'price': item['subscriptionTypes'] != null && item['subscriptionTypes'].isNotEmpty
                  ? '${item['subscriptionTypes'][0]['price']} €'
                  : 'Prix indisponible',
              'stock': item['available_stock'] != null && item['available_stock'] > 0
                  ? 'Disponible'
                  : 'Indisponible',
            };
          }).toList();

          return productList;
        } else {
          throw Exception('La clé "member" est absente dans la réponse.');
        }
      } else {
        throw Exception('Erreur de chargement des produits');
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }
}
