import 'dart:convert';
import 'package:http/http.dart' as http;

class GetOrderItem {
  final String baseUrl;
  final String token;

  GetOrderItem({required this.baseUrl, required this.token});

  Future<Map<String, dynamic>> fetchItem(String endpoint) async {
    String cleanedEndpoint = endpoint.startsWith('/api')
        ? endpoint.replaceFirst('/api', '')
        : endpoint;

    final fullUrl = Uri.parse('$baseUrl$cleanedEndpoint');
    final response = await http.get(
      fullUrl,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erreur lors de la récupération de $endpoint');
    }
  }
}