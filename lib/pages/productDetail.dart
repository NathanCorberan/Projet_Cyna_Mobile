import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'Détail du produit'),
        backgroundColor: const Color(0xFF302082),
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

            // Nom du produit
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

            // Description
            Text(
              product['description'] ?? 'Aucune description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Prix
            Text(
              'Prix : ${product['price'] ?? '-'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Stock
            Text(
              'Stock : ${product['stock'] ?? '-'}',
              style: TextStyle(
                fontSize: 16,
                color: product['stock'] == 'Disponible' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 24),

            // Bouton Ajouter au panier
            ElevatedButton(
              onPressed: () {
                // TODO: Ajouter la logique d'ajout au panier ici
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produit ajouté au panier')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF302082),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Ajouter au panier',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
