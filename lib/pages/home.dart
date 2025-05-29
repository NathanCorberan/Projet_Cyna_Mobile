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
    // On ne peut pas utiliser context dans initState, donc on reporte au didChangeDependencies
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
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                    childAspectRatio: 1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategorieDetail(
                              categoryData: [category], // on passe une liste contenant la catégorie sélectionnée
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF302082),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                      height: 320, // Hauteur adaptée à la carte
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
