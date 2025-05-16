import 'package:flutter/material.dart';
import 'package:cynamobile/apiRequest/getProductByCategorie.dart';

class CategorieDetail extends StatelessWidget {
  final dynamic categoryData;

  const CategorieDetail({Key? key, required this.categoryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = "http://${categoryData[0]['imageLink']}";
    String categoryName = categoryData[0]['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails des catégories',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF302082),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Stack(
                    children: [
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent,
                          shadows: [
                            Shadow(color: Colors.white, offset: Offset(0, 0)),
                          ],
                        ),
                      ),
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: GetProductByCategorie.fetchProductsByCategorie(categoryData[0]['id']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Aucun produit trouvé.'));
                }

                final products = snapshot.data!;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 270,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final bool isOutOfStock = product.available_stock == 0;

                    return Card(
                      color: isOutOfStock ? Colors.red.shade100 : null,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: product.image.isNotEmpty
                                  ? Image.network(
                                product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                              )
                                  : const Center(child: Icon(Icons.image_not_supported)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.price,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                          Text(
                            isOutOfStock ? 'stock épuisé' : product.available_stock.toString() + " en stock",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isOutOfStock ? Colors.red.shade700 : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
