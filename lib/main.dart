import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:provider/provider.dart';
import 'providers/var_provider.dart';
import 'providers/cart_provider.dart';
import 'pages/panier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VarProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBar',
      theme: ThemeData(
        primaryColor: Color(0xFF302082),
      ),
      home: HomePage(),
      routes: {
        '/cart': (context) => const PanierPage(),
      },
    );
  }
}
