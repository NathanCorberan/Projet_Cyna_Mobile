import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import './login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget  {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _createAccount() async {
    String email = emailController.text;
    String name = nameController.text;
    String prenom = prenomController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      print("Les mots de passe ne correspondent pas !");
      return;
    }

    final String apiUrl = "http://api.juku7704.odns.fr/api/users"; // Remplace par ton URL d'API

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "first_name": name,
          "last_name": prenom,
          "password": password,
          "isActivate": true
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Compte créé avec succès : ${response.body}");
      } else {
        print("Erreur : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erreur de connexion : $e");
    }
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
                      _buildTextField("Email", emailController),
                      SizedBox(height: 10),
                      _buildTextField("Nom", nameController),
                      SizedBox(height: 10),
                      _buildTextField("Prénom", prenomController),
                      SizedBox(height: 10),
                      _buildTextField("Mot de passe", passwordController, obscureText: true),
                      SizedBox(height: 10),
                      _buildTextField("Confirmer mot de passe", confirmPasswordController, obscureText: true),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF302082)),
        hintText: 'Entrez votre $label',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF302082), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF302082), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
