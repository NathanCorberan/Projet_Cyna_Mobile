import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static Future<void> payWithStripe({
    required BuildContext context,
    required int orderId,
    required String userToken,
  }) async {
    try {
      print('[Stripe] ➤ Début du paiement pour Order ID: $orderId');

      final setupIntentResponse = await http.post(
        Uri.parse('http://srv839278.hstgr.cloud:8000/api/payment/setup-intent'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'order_id': orderId}),
      );

      print('[Stripe] ➤ Réponse setup-intent: ${setupIntentResponse.statusCode}');
      print('[Stripe] ➤ Body: ${setupIntentResponse.body}');

      if (setupIntentResponse.statusCode != 200) {
        throw Exception('Erreur setup-intent: ${setupIntentResponse.body}');
      }

      final setupIntentData = jsonDecode(setupIntentResponse.body);
      final clientSecret = setupIntentData['client_secret'];
      print('[Stripe] ➤ clientSecret reçu: $clientSecret');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: clientSecret,
          merchantDisplayName: 'Mon App',
          style: ThemeMode.light,
        ),
      );
      print('[Stripe] ➤ PaymentSheet initialisé');

      await Stripe.instance.presentPaymentSheet();
      print('[Stripe] ✅ Paiement confirmé par l’utilisateur');

      final checkoutResponse = await http.post(
        Uri.parse('http://srv839278.hstgr.cloud:8000/api/payment/checkout'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'order_id': orderId,
          "payment_method_id": "pm_1RTmuh2NsckbDruQmJ4BnGgr",
        }),
      );
      print('[Stripe] ➤ checkout response: ${checkoutResponse.statusCode}');

      if (checkoutResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paiement réussi ✅')),
        );
        Navigator.pushNamed(context, '/success');
      } else {
        throw Exception('Échec backend : ${checkoutResponse.body}');
      }
    } on StripeException catch (e) {
      final message = e.error.message ?? 'Erreur Stripe inconnue';
      print('[Stripe] ⚠️ StripeException: $message');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur Stripe : $message')),
      );
    } catch (e) {
      print('[Stripe] ❌ Exception non Stripe: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }
}
