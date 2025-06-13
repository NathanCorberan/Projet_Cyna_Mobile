import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/var_provider.dart';
import '../pages/home.dart';
import '../widgets/header_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './createAccount.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool errorOnConnexion = false;
  bool _isPasswordVisible = false;

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;
    final varProvider = Provider.of<VarProvider>(context, listen: false);

    final String apiUrl = "${varProvider.url}/login";
    final String apiMeUrl = "${varProvider.url}/me";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];

        if (varProvider.userVariable == null) {
          varProvider.updateUserVariable({
            'first_name': '',
            'last_name': '',
            'email': '',
          });
        }

        varProvider.userVariable?.updateUserToken(token);

        final responseUser = await http.get(
          Uri.parse(apiMeUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        if (responseUser.statusCode == 200) {
          varProvider.updateUserVariable(responseUser.body);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          setState(() {
            errorOnConnexion = true;
          });
        }
      } else {
        setState(() {
          errorOnConnexion = true;
        });
      }
    } catch (e) {
      setState(() {
        errorOnConnexion = true;
      });
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF302082), width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "Connexion",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    _buildTextField("Email", emailController),
                    SizedBox(height: 10),
                    _buildTextField("Mot de passe", passwordController,
                        obscureText: !_isPasswordVisible),
                    SizedBox(height: 10),
                    if (errorOnConnexion)
                      Text(
                        "Email ou mot de passe incorrect",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: _login,
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF302082),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () => _goToChangePassword(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nouveau ?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () => _goToLogin(context),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            overlayColor: Colors.transparent,
                          ),
                          child: Text(
                            "Créez un compte",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Container(height: 2, color: Color(0xFF302082)),
                    SizedBox(height: 10),
                    Text(
                      "Ou connectez-vous avec",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.google,
                              color: Color(0xFF302082), size: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.facebook,
                              color: Color(0xFF302082), size: 30),
                          onPressed: () {},
                        ),
                      ],
                    )
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
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
        suffixIcon: label.toLowerCase().contains("mot de passe")
            ? GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            color: Color(0xFF302082),
          ),
        )
            : Icon(icon, color: Color(0xFF302082)),
      ),
    );
  }
}
