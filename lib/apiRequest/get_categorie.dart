import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/var_provider.dart';

class GetCategorie {
  static Future<List<dynamic>> fetchCategorie(BuildContext context) async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final String url = '${varProvider.url}/categories';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('member')) {
          List<dynamic> categories = jsonResponse['member'];
          return categories;
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
