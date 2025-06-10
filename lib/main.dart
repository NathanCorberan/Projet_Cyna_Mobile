import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'pages/panier.dart';
import 'providers/var_provider.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = 'pk_test_51RRVpj2NsckbDruQ663hlj28B3JEF8lVNKl7EA8xdRo8A4H9EXbb2TKKrjZ4t5HhYuDtVFW67JYAsSQD3Qp5Y9Ru009RHSvrzl'; // 🔁 Remplace par ta vraie clé
  await Stripe.instance.applySettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VarProvider()),
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
        '/success': (context) => SuccessPage(), // 🔁 Crée une page si tu rediriges vers /success
      },
    );
  }
}

// 🔁 Exemple rapide de page succès
class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Succès")),
      body: Center(child: Text("Paiement réussi 🎉")),
    );
  }
}
