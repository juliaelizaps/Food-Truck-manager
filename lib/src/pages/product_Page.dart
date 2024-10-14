import 'package:flutter/material.dart';

import '../shared/components/sideBar.dart';

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
      drawer:const SideBar(),
      body: const Center(
        child: Text(
          'visualize aqui os produtos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}