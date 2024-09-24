import 'package:flutter/material.dart';
import 'package:projeto_1/pages/addProduct.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('Todos'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Lanches'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Bebidas'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Porções'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Pasteis'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Molhos'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('Adicionais'),
                  onSelected: (bool value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
