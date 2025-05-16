import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String name;
  final String description;
  final String image;
  final String price;
  final int available_stock;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.available_stock,
  });
}

class GetProductByCategorie {
  static Future<List<Product>> fetchProductsByCategorie(int categoryId) async {
    final url = 'http://api.juku7704.odns.fr/api/categorie/$categoryId/products?page=1';

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
        String name = 'Nom indisponible';
        String description = 'Description indisponible';
        String image = '';
        String price = 'Non renseigné';

        if (item['productLangages'] != null && item['productLangages'] is List && item['productLangages'].isNotEmpty) {
          name = 'Produit ${item['id']}';
          description = 'Description du produit ${item['id']}';
        }

        if (item['productImages'] != null && item['productImages'] is List && item['productImages'].isNotEmpty) {
          image = 'https://picsum.photos/500/500';
        }

        if (item['subscriptionTypes'] != null && item['subscriptionTypes'] is List && item['subscriptionTypes'].isNotEmpty) {
          price = '150.00€';
        }

        products.add(Product(
          name: name,
          description: description,
          image: image,
          price: price,
          available_stock: item['available_stock'] ?? 0,
        ));
      }

      return products;
    } catch (e) {
      throw Exception('Erreur lors du chargement des produits: $e');
    }
  }
}
