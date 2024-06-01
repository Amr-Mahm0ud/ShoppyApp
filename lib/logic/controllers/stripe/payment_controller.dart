import 'dart:convert';

import 'package:shoppy/utils/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shoppy/utils/keys.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentController {
  static Future<void> makePayment(
      {required int amount, String currency = 'USD'}) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);

      await _initializePaymentSheet(clientSecret);
      // await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      Consts.errorSnackBar(error);
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${AppKeys.secretKey}',
      'Content-type': 'application/x-www-form-urlencoded',
    };
    final Map<String, String> body = {
      'amount': amount,
      'currency': currency,
    };
    final http.Response res = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: headers,
      body: body,
    );
    final resBody = json.decode(res.body);
    return resBody['client_secret'];
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    // await Stripe.instance.initPaymentSheet(
    //   paymentSheetParameters: SetupPaymentSheetParameters(
    //     paymentIntentClientSecret: clientSecret,
    //     merchantDisplayName: '3mr',
    //   ),
    // );
  }
}
