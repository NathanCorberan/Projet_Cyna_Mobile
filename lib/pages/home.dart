import 'package:cynamobile/apiRequest/get_product.dart';
import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import 'package:provider/provider.dart';
import 'package:cynamobile/providers/VarProvider.dart';
import '../apiRequest/get_categorie.dart'; // Importation du fichier API

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [];
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadTopProduct();
  }

  Future<void> _loadCategories() async {
    try {
      List<String> fetchedCategorie = await GetCategorie.fetchCategorie();
      setState(() {
        categories = fetchedCategorie;
      });
    } catch (e) {
      print("Erreur lors du chargement des catégories: $e");
    }
  }

  Future<void> _loadTopProduct() async {
    try {
      List<Map<String, dynamic>> fetchedTopProduct = await GetTopProduct.fetchTopProduct();
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
            SizedBox(height: 40),
            Text(
              "Actualité et nouveauté",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF302082),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFF2F2F2),
              ),
              child: Text(
                "Aucun évenement en cours ...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Catégorie",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                    childAspectRatio: 1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF302082),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Top du moment",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];

                    String productName = product['name'] ?? 'Nom indisponible';
                    String productDescription = product['description'] ?? 'Description indisponible';
                    String productImage = product['image'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20), // Ajout d'un espace entre les blocs
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF302082),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            productImage.isNotEmpty
                                ? Image.network(
                              productImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            )
                                : Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                              child: Center(child: Text("Image non disponible")),
                            ),
                            SizedBox(height: 20), // Espacement après l'image
                            Text(
                              productName,
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10), // Espacement après le nom
                            Text(
                              productDescription,
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
