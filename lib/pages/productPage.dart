import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [

        ],
      ),
      body: const Center(
        child: Text(
          'Adicione aqui seus produtos!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}
