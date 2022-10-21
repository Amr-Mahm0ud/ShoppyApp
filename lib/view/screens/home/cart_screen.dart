import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
        leading: const BackButton(),
      ),
      body: const Center(
        child: Text('CartScreen'),
      ),
    );
  }
}
