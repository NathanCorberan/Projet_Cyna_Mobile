import '../pages/home.dart';
import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import './createAccount.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/VarProvider.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Login extends StatefulWidget  {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool errorOnConnexion = false;

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;
    final varProvider = Provider.of<VarProvider>(context, listen: false);

    final String apiUrl = "http://api.juku7704.odns.fr/api/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Compte connecté avec succès : ${response.body}");

        Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        //print("Token décodé : $decodedToken");

        final responseUser = await http.get(
          Uri.parse("http://api.juku7704.odns.fr/api/me"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer "+ token,
          },
        );
        //print(responseUser.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        varProvider.updateUserVariable(responseUser.body);
      } else {
        errorOnConnexion = true;
        _LoginState;
        print("Erreur : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      errorOnConnexion = true;
      _LoginState;
      print("Erreur de connexion : $e");
    }
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccount()),
    );
  }

  void _goToChangePassword(BuildContext context) {
    // TODO aller a changer de mot de passe
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderMenu(),
            SizedBox(height: 50),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF302082),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFFFFFF),
                ),
                child:
                Column(
                  children: [
                    Text(
                      "Connexion",
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
                    _buildTextField("Mot de passe", passwordController, obscureText: true),
                    SizedBox(height: 10),
                    if (errorOnConnexion) Text(
                      "Email ou mot de passe incorrect",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: _login,
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF302082),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () => _goToChangePassword(context),
                      child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )
                      ),
                    ),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nouveau ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            overlayColor: Colors.transparent,
                          ),
                          onPressed: () => _goToLogin(context),
                          child: Text(
                              "Créez un compte",
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
                      height: 2.0,
                      color: Color(0xFF302082),
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
    IconData icon;

    switch (label.toLowerCase()) {
      case "email":
        icon = Icons.email;
        break;
      case "nom":
      case "prénom":
        icon = Icons.person;
        break;
      case "mot de passe":
      case "confirmer mot de passe":
        icon = Icons.lock;
        break;
      default:
        icon = Icons.text_fields;
    }

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
        suffixIcon: Icon(icon, color: Color(0xFF302082)),
      ),
    );
  }}
