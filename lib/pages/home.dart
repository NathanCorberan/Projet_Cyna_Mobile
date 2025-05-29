import 'package:cynamobile/apiRequest/get_product.dart';
import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import 'package:provider/provider.dart';
import 'package:cynamobile/providers/var_provider.dart';
import '../apiRequest/get_categorie.dart';
import 'package:cynamobile/pages/CategorieDetail.dart';
import 'package:cynamobile/widgets/product_card.dart';
import 'package:cynamobile/pages/productDetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> categories = [];
  List<Map<String, String>> products = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCategories();
    _loadTopProduct();
  }

  Future<void> _loadCategories() async {
    try {
      List<dynamic> fetchedCategorie = await GetCategorie.fetchCategorie(context);
      setState(() {
        categories = fetchedCategorie;
      });
    } catch (e) {
      print("Erreur lors du chargement des catégories: $e");
    }
  }

  Future<void> _loadTopProduct() async {
    try {
      List<Map<String, String>> fetchedTopProduct = await GetTopProduct.fetchTopProduct(context);
      setState(() {
        products = fetchedTopProduct;
      });
    } catch (e) {
      print("Erreur lors du chargement des produits: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final varProvider = Provider.of<VarProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderMenu(),
            const SizedBox(height: 40),
            const Text(
              "Actualité et nouveauté",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF302082),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF2F2F2),
              ),
              child: const Text(
                "Aucun évenement en cours ...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Catégorie",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final String imageUrl = category['imageLink'] != null && category['imageLink'].isNotEmpty
                        ? "http://${category['imageLink']}"
                        : '';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategorieDetail(
                              categoryData: [category],
                            ),
                          ),
                        );
                      },
                      child: Card(
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
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                                )
                                    : const Center(child: Icon(Icons.image_not_supported)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category['name'] ?? 'Nom inconnu',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Top du moment",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 320,
                      child: ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
