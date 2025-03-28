import 'dart:convert';
import 'package:http/http.dart' as http;

class GetCategorie {
  static const String _url = 'http://api.juku7704.odns.fr/api/categories';

  static Future<List<String>> fetchCategorie() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('member')) {
          List<dynamic> categories = jsonResponse['member'];

          List<String> categoryNames = categories.map((item) => item['name'] as String).toList();

          return categoryNames;
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
