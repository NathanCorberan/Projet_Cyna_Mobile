import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    double total = 0;
    for (var item in items) {
      final price = double.tryParse(item.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
      total += price * item.quantity;
    }

    const shipping = 4.99;
    final totalWithShipping = total + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panier',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF302082),
      ),
      body: SafeArea(
        child: items.isEmpty
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
              _buildSummaryBox(context, total, shipping, totalWithShipping),
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
                    Text("Prix unitaire : ${item.price}"),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cart.removeFromCart(item),
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
        onPressed: () {
          cartProvider.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Commande passée avec succès")),
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
