import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails du produit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF302082),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (product['image'] != null && product['image']!.isNotEmpty)
              Image.network(
                product['image']!,
                height: 250,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            const SizedBox(height: 16),
            Text(
              product['name'] ?? 'Nom inconnu',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302082),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              product['description'] ?? 'Aucune description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Prix : ${product['price'] ?? '-'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock : ${product['stock'] ?? '-'}',
              style: TextStyle(
                fontSize: 16,
                color: product['stock'] == 'Disponible' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(
                  CartItem(
                    name: product['name'] ?? '',
                    price: product['price'] ?? '',
                    image: product['image'] ?? '',
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Produit ajouté au panier")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF302082),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Ajouter au panier',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
