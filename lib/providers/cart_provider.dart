import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';
import '../providers/var_provider.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  Future<void> addToCart(CartItem item, VarProvider varProvider) async {
    final user = varProvider.userVariable;
    if (user == null || user.userToken.isEmpty) {
      debugPrint("Utilisateur non connecté ou token manquant");
      return;
    }

    if (varProvider.orderId == null) {
      final String postUrl = "${varProvider.url}/orders";
      const String cartToken = "cart-token-1234";

      final Map<String, dynamic> body = {
        "key": cartToken,
        "user": user.id.toString(),
      };

      try {
        final response = await http.post(
          Uri.parse(postUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${user.userToken}",
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 201) {
          final data = jsonDecode(response.body);
          final orderId = data['id'];
          varProvider.setOrderId(orderId);
          debugPrint("Commande créée avec ID : $orderId");
        } else {
          debugPrint("Erreur création commande : ${response.statusCode}");
          return;
        }
      } catch (e) {
        debugPrint("Erreur réseau création commande : $e");
        return;
      }
    }

    final String orderItemUrl = "${varProvider.url}/order_items";

    debugPrint("zdqzdzqdzqd ${item.productId}");
    final Map<String, dynamic> itemBody = {
      "product_id": item.productId,
      "quantity": item.quantity,
      "subscription_type_id": item.subscriptionTypeId ?? 0,
    };

    try {
      final response = await http.post(
        Uri.parse(orderItemUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.userToken}",
        },
        body: jsonEncode(itemBody),
      );

      if (response.statusCode == 201) {
        debugPrint("✅ Article ajouté à la commande avec succès !");
      } else {
        debugPrint("❌ Erreur ajout article : ${response.statusCode}");
        debugPrint("Réponse : ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Erreur réseau ajout article : $e");
    }
  }


  void removeFromCart(CartItem item) {
    final index = _items.indexWhere((element) =>
    element.name == item.name &&
        element.price == item.price &&
        element.image == item.image);

    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
