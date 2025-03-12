import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import './login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAccount extends StatelessWidget {

  void _createAccount() {
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Ajout du scroll
        child: Column(
          children: [
            HeaderMenu(),
            SizedBox(height: 50), // Ajoute un espacement pour ne pas coller le HeaderMenu au Container
            Center( // Centre le container horizontalement et verticalement
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20), // Espacement à gauche et à droite
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF302082),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                  color: Color(0xFFFFFFFF), // Fond blanc
                ),
                child:
                  Column(
                    children: [
                      Text(
                        "Créer un compte",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF302082)), // Couleur du texte du label
                          hintText: 'Entrez votre email', // Texte par défaut à l'intérieur du TextField
                          hintStyle: TextStyle(color: Colors.grey), // Style du texte hint
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue quand actif
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          labelStyle: TextStyle(color: Color(0xFF302082)), // Couleur du texte du label
                          hintText: 'Entrez votre nom', // Texte par défaut à l'intérieur du TextField
                          hintStyle: TextStyle(color: Colors.grey), // Style du texte hint
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue quand actif
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Prenom',
                          labelStyle: TextStyle(color: Color(0xFF302082)), // Couleur du texte du label
                          hintText: 'Entrez votre prenom', // Texte par défaut à l'intérieur du TextField
                          hintStyle: TextStyle(color: Colors.grey), // Style du texte hint
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue quand actif
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'mot de passe',
                          labelStyle: TextStyle(color: Color(0xFF302082)), // Couleur du texte du label
                          hintText: 'Entrez votre mot de passe', // Texte par défaut à l'intérieur du TextField
                          hintStyle: TextStyle(color: Colors.grey), // Style du texte hint
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue quand actif
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'confirmation mot de passe',
                          labelStyle: TextStyle(color: Color(0xFF302082)), // Couleur du texte du label
                          hintText: 'Veuillez confirmer mot de passe', // Texte par défaut à l'intérieur du TextField
                          hintStyle: TextStyle(color: Colors.grey), // Style du texte hint
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF302082), width: 1), // Bordure bleue quand actif
                            borderRadius: BorderRadius.circular(10), // Coins arrondis
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: _createAccount, // Remplacez par votre fonction d'action
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF302082), // Fond bleu #302082
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Coins arrondis
                          ),
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15), // Espacement interne du bouton
                        ),
                        child: Text(
                          "Créer un compte",
                          style: TextStyle(
                            color: Colors.white, // Texte blanc
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Déja Client ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(  // Rounded corners
                                borderRadius: BorderRadius.circular(12),
                              ),
                              overlayColor: Colors.transparent, // Disable the color change on press
                            ),
                            onPressed: () => _goToLogin(context),
                                child: Text(
                                    "Connectez-vous",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                  )
                              ),
                          )
                        ],
                      ),
                      Container(
                        height: 2.0,  // Hauteur du trait
                        color: Color(0xFF302082),  // Couleur bleue du trait
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Ou connectez-vous avec",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                                FontAwesomeIcons.google,
                                color: Color(0xFF302082),
                              size: 30,
                            ),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Color(0xFF302082),
                              size: 30,
                            ),                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
