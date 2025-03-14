import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import 'package:provider/provider.dart';
import 'package:cynamobile/providers/VarProvider.dart';


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
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF302082),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              products[index]['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
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
