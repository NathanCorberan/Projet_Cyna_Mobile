import 'package:flutter/material.dart';
import 'widgets/header_menu.dart';

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
      home: HeaderMenu(),
    );
  }
}
