import 'package:flutter/material.dart';
import 'pages/home.dart'; // Met à jour l'import avec le bon chemin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar',
      theme: ThemeData(
        primaryColor: Color(0xFF302082),
      ),
      home: HomePage(), // Afficher HomePage
    );
  }
}
