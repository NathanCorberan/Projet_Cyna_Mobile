import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apiRequest/get_order.dart';
import '../apiRequest/get_order_item.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/var_provider.dart';
import '../services/stripe_service.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  bool isLoading = true;
  String? error;
  List<CartItem> items = [];

  Future<void> _fetchCart() async {
    final varProvider = Provider.of<VarProvider>(context, listen: false);
    final orderId = varProvider.orderId;
    final user = varProvider.userVariable;

    if (orderId == null || user == null || user.userToken.isEmpty) {
      setState(() {
        error = "Utilisateur non connecté ou aucune commande en cours.";
        isLoading = false;
      });
      return;
    }

    try {
      final getOrder = GetOrder(baseUrl: varProvider.url, token: user.userToken);
      final orderData = await getOrder.fetchOrder(orderId);
      print(orderData);

      if (orderData['status'] == "cart") {
        final List<dynamic> orderItemsRaw = orderData['orderItems'] ?? [];

        final getOrderItem = GetOrderItem(baseUrl: varProvider.url, token: user.userToken);
        final List<CartItem> loadedItems = [];
        for (var orderItemData in orderItemsRaw) {
          Map<String, dynamic> orderItem;

          if (orderItemData is String) {
            orderItem = await getOrderItem.fetchItem(orderItemData);
          } else if (orderItemData is Map) {
            orderItem = Map<String, dynamic>.from(orderItemData);
          } else {
            continue;
          }

          final productEndpoint = orderItem['product'] as String;
          final product = await getOrderItem.fetchItem(productEndpoint);
          final List<dynamic> member = product['member'] ?? [];

          final List<dynamic> productLanguages = member.length > 5 && member[5] is List
              ? member[5]
              : [];

          final List<dynamic> productImages = member.length > 6 && member[6] is List
              ? member[6]
              : [];

          final List<dynamic> subscriptions = member.length > 7 && member[7] is List
              ? member[7]
              : [];

          final String name = productLanguages.isNotEmpty && productLanguages[0] is Map
              ? productLanguages[0]['name'] ?? 'Produit sans nom'
              : 'Produit sans nom';

          final String imageUrl = productImages.isNotEmpty && productImages[0] is Map
              ? '${varProvider.productImageUrl}${productImages[0]['image_link']}'
              : '';

          final double price = subscriptions.isNotEmpty && subscriptions[0] is Map
              ? double.tryParse(
            (subscriptions[0]['price'] ?? '0')
                .toString()
                .replaceAll('€', '')
                .trim(),
          ) ??
              0.0
              : 0.0;

          print(imageUrl);

          loadedItems.add(CartItem(
            productId: member[0],
            name: name,
            price: price,
            quantity: orderItem['quantity'] ?? 1,
            image: imageUrl,
          ));
        }

        setState(() {
          items = loadedItems;
          isLoading = false;
          error = null;
        });
      }
    } catch (e) {
      setState(() {
        error = "Erreur lors du chargement : $e";
        isLoading = false;
      });
    }
  }



  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final double subtotal = items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    const double shipping = 0;
    final double total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panier',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF302082),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(child: Text(error!))
            : items.isEmpty
            ? const Center(child: Text("Votre panier est vide."))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Vos articles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...items.map((item) => _buildCartItem(context, item)).toList(),
              const SizedBox(height: 24),
              _buildSummaryBox(context, subtotal, shipping, total),
              const SizedBox(height: 16),
              _buildCheckoutButton(context, cart),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.image.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 40),
                ),
              )
                  : Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 40),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text("Prix unitaire : ${item.price.toStringAsFixed(2)} €"),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          cart.removeFromCart(item);
                          setState(() {
                            items.remove(item);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (item.quantity > 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${item.quantity}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSummaryBox(
      BuildContext context, double subtotal, double shipping, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Sous-total", "${subtotal.toStringAsFixed(2)}€"),
          const SizedBox(height: 8),
          _buildSummaryRow("Frais de port", "${shipping.toStringAsFixed(2)}€"),
          const SizedBox(height: 8),
          const Divider(thickness: 1),
          const SizedBox(height: 8),
          _buildSummaryRow("Total", "${total.toStringAsFixed(2)}€", isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
          isBold ? const TextStyle(fontWeight: FontWeight.bold) : const TextStyle(),
        ),
        Text(
          amount,
          style:
          isBold ? const TextStyle(fontWeight: FontWeight.bold) : const TextStyle(),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, CartProvider cartProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final varProvider = Provider.of<VarProvider>(context, listen: false);
          final user = varProvider.userVariable;

          if (user == null || user.userToken.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Utilisateur non connecté")),
            );
            return;
          }

          final int? orderId = varProvider.orderId;
          if (orderId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Aucune commande en cours")),
            );
            return;
          }

          await StripeService.payWithStripe(
            context: context,
            orderId: orderId,
            userToken: user.userToken,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF302082),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          "Procéder au paiement",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
