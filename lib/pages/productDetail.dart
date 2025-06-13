import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../providers/var_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final varProvider = Provider.of<VarProvider>(context, listen: false);

    final String baseImageUrl = varProvider.productImageUrl ?? '';
    final String fullImageUrl =
    product.image.isNotEmpty ? '$baseImageUrl${product.image}' : '';

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
            if (fullImageUrl.isNotEmpty)
              Image.network(
                fullImageUrl,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302082),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Prix : ${product.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock : ${product.stock}',
              style: TextStyle(
                fontSize: 16,
                color: product.stock == 'Disponible' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(
                  CartItem(
                    name: product.name,
                    price: product.price,
                    image: fullImageUrl, // ✅ Utiliser l'URL complète ici aussi
                    productId: product.id,
                  ),
                  varProvider,
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
