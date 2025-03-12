import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';

class HomePage extends StatelessWidget {
  List<String> categories = [
    "SOC", "EDR", "XDR", "IAM", "Sécurité Cloud", "Sécurité Applis",
    "Protection APT", "Gestion Risques", "Sécurité Réseaux",
    "Sécurisation Données", "SD-WAN Security"
  ];

  List<Map<String, String>> products = [
    {
      "name": "Firewall Avancé",
      "description": "Protégez votre réseau avec un pare-feu avancé.",
      "image": "assets/images/firewall.jpeg"
    },
    {
      "name": "Antivirus Pro",
      "description": "Détection et suppression des menaces en temps réel.",
      "image": "assets/images/antivirus.png"
    },
    {
      "name": "Cloud Security",
      "description": "Sécurisez vos données et applications dans le cloud.",
      "image": "assets/images/cloud_security.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Ajout du scroll
        child: Column(
          children: [
            HeaderMenu(), // Header avec le menu intégré
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
              padding: EdgeInsets.all(10), // Espace interne
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF302082),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10), // Coins arrondis
                color: Color(0xFFF2F2F2), // Fond blanc
              ),
              child: Text(
                "Voici un texte dans un cadre avec une bordure bleue.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
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
                  shrinkWrap: true, // Permet au GridView de prendre seulement l'espace nécessaire
                  physics: NeverScrollableScrollPhysics(), // Désactive le scrolling interne du GridView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Nombre de colonnes
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.05, // Espacement horizontal de 5%
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.05, // Espacement vertical de 5%
                    childAspectRatio: 1, // Ajuste la hauteur/largeur des cases pour une proportion carrée
                  ),
                  itemCount: categories.length, // Le nombre d'éléments à afficher
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center, // Centrage du texte horizontal et vertical
                      decoration: BoxDecoration(
                        color: Color(0xFF302082), // Fond de la case
                        borderRadius: BorderRadius.circular(12), // Bordures arrondies
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white, // Couleur du texte
                          fontSize: 16, // Taille du texte
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center, // Centrage du texte horizontalement
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true, // Permet au GridView de prendre seulement l'espace nécessaire
                  physics: NeverScrollableScrollPhysics(), // Désactive le scrolling interne du GridView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Nombre de colonnes
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.05, // Espacement horizontal de 5%
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.05, // Espacement vertical de 5%
                  ),
                  itemCount: products.length, // Le nombre d'éléments à afficher
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center, // Centrage du texte horizontal et vertical
                      decoration: BoxDecoration(
                        color: Color(0xFF302082), // Fond de la case
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8, // Fixe la largeur à 80% de la largeur de l'écran
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // La colonne s'adapte à la hauteur du contenu
                          children: [
                            Image.asset(
                              products[index]['image']!,
                              fit: BoxFit.cover, // Utilisation de BoxFit.cover pour ajuster l'image
                              width: double.infinity, // Prend toute la largeur disponible
                              height: 200, // Fixe une hauteur pour l'image
                            ),
                            SizedBox(height: 20),
                            Text(
                              products[index]['name']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              products[index]['description']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
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
