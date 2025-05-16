import 'dart:convert';
import 'package:http/http.dart' as http;

class GetTopProduct {
  static const String _url = 'http://api.juku7704.odns.fr/api/products';

  static Future<List<Map<String, String>>> fetchTopProduct() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('member')) {
          List<dynamic> products = jsonResponse['member'];

          // Maintenant, on construit la liste avec les informations disponibles
          List<Map<String, String>> productList = products.map((item) {
            String name = item['productLangages'] != null && item['productLangages'].isNotEmpty
                ? item['productLangages'][0]['name'] ?? 'Nom indisponible'
                : 'Nom indisponible';
            String description = item['productLangages'] != null && item['productLangages'].isNotEmpty
                ? item['productLangages'][0]['description'] ?? 'Description indisponible'
                : 'Description indisponible';
            String image = item['productImages'] != null && item['productImages'].isNotEmpty
                ? item['productImages'][0]['image_link'] ?? ''
                : ''; // Assure que l'image est présente

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
