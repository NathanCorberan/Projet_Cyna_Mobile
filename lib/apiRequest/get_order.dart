import 'dart:convert';
import 'package:http/http.dart' as http;

class GetOrder {
  final String baseUrl;
  final String token;

  GetOrder({required this.baseUrl, required this.token});

  Future<Map<String, dynamic>> fetchOrder(int orderId) async {
    final url = Uri.parse('$baseUrl/orders/$orderId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }
}
