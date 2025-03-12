import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderMenu extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HeaderMenuState createState() => _HeaderMenuState();

  @override
  Size get preferredSize => Size.fromHeight(80.0); // Hauteur de l'AppBar
}

class _HeaderMenuState extends State<HeaderMenu> {
  bool _isResearch = false;
  FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isResearch = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _openMenu() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 105, // Juste en dessous de l'AppBar
        bottom: 0,
        right: 0,
        width: 200,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Color(0xFF302082),
            child: Column(
              children: [
                _menuItem("Catégorie"),
                _menuItem("Recherche"),
                _menuItem("Produit"),
                _menuItem("Utilisateurs"),
                Expanded(child: Container()), // Espacement
                _menuItem("Mentions légales"),
                _menuItem("CGU"),
                _menuItem("Contact"),
                _socialIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String title) {
    return TextButton(
      onPressed: _toggleMenu,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Widget _socialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(FontAwesomeIcons.instagram, color: Colors.white), onPressed: () {}),
        IconButton(icon: Icon(FontAwesomeIcons.twitter, color: Colors.white), onPressed: () {}),
        IconButton(icon: Icon(FontAwesomeIcons.linkedinIn, color: Colors.white), onPressed: () {}),
        IconButton(icon: Icon(FontAwesomeIcons.facebook, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF302082),
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://static.wixstatic.com/media/d9da11_f0ddbd894a0c4eeba7b96fdf02a011e9~mv2.png/v1/fill/w_342,h_98,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Logo%20Cyna%20Purple%20and%20white.png',
            fit: BoxFit.contain,
            height: 40,
            cacheWidth: 1000,
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
                icon: Icon(_isMenuOpen ? Icons.close : Icons.menu, color: Colors.white),
                onPressed: _toggleMenu,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
