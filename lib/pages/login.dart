import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Ajout du scroll
        child: Column(
          children: [
            HeaderMenu(),
          ],
        ),
      ),
    );
  }
}
