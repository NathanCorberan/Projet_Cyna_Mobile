// lib/widgets/header_menu.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderMenu extends StatefulWidget {
  @override
  _HeaderMenuState createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  bool _isMenuOpen = false;
  bool _isResearch = false;
  bool _isCommandeOpen = false;  // Nouvelle variable pour gérer l'état du menu "Commandes"
  FocusNode _focusNode = FocusNode();

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _toggleCommandeMenu() {
    setState(() {
      _isCommandeOpen = !_isCommandeOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange); // Ajoute un écouteur pour détecter le focus
  }

  void _onFocusChange() {
    setState(() {
      _isResearch = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Nettoyage du FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF302082),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
              child: Image.network(
                'https://static.wixstatic.com/media/d9da11_f0ddbd894a0c4eeba7b96fdf02a011e9~mv2.png/v1/fill/w_342,h_98,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Logo%20Cyna%20Purple%20and%20white.png',
                fit: BoxFit.contain,
                height: 40,
                cacheWidth: 1000,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Rechercher...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                if (!_isResearch) IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {},
                ),
                if (!_isResearch) IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {},
                ),
                if (!_isResearch) IconButton(
                  icon: _isMenuOpen ? Icon(Icons.close, color: Colors.white) : Icon(Icons.menu, color: Colors.white),
                  onPressed: _toggleMenu,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Affichage du menu seulement si _isMenuOpen est vrai
          if (_isMenuOpen)
            Positioned(
              bottom: 0,
              top: 2, // Commence tout en haut
              right: 0, // Place le menu à droite
              child: Container(
                color: Color(0xFF302082), // Fond coloré pour mieux visualiser
                width: 200,
                height: MediaQuery.of(context).size.height, // Hauteur de l'écran
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _toggleMenu,
                      child: Text(
                        "Catégorie",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleMenu,
                      child: Text(
                        "Recherche",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleMenu,
                      child: Text(
                        "Produit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleMenu,
                      child: Text(
                        "Utilisateurs",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    // Bouton "Commandes" avec flèche qui change de direction
                    TextButton(
                      onPressed: _toggleCommandeMenu,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commandes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            _isCommandeOpen
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Affiche les sous-options si _isCommandeOpen est vrai
                    if (_isCommandeOpen)
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Option 1",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Option 2",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Option 3",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    // Espacement flexible avant les icônes
                    Expanded(
                      child: Container(),
                    ),
                    // Boutons supplémentaires en bas avant les icônes des réseaux sociaux
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Mentions légales",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "CGU",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Contact",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    // Icônes des réseaux sociaux en bas
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Scrollable horizontalement
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.twitter, color: Colors.white), // Twitter icon
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.linkedinIn, color: Colors.white), // LinkedIn icon
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.facebook, color: Colors.white), // Facebook icon
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ), // Le reste du contenu
    );
  }
}
