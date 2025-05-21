import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Panier'),
        backgroundColor: const Color(0xFF302082),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Votre panier est vide.'))
          : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final item = cart.items[index];
          return ListTile(
            leading: Image.network(
              item.image,
              width: 50,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
            ),
            title: Text(item.name),
            subtitle: Text('Prix : ${item.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => cart.removeFromCart(item),
            ),
          );
        },
      ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            cart.clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Commande validée !')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF302082),
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Valider la commande'),
        ),
      )
          : null,
    );
  }
}
