import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [

        ],
      ),
      body: const Center(
        child: Text(
          'visualize aqui os pedidos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}
