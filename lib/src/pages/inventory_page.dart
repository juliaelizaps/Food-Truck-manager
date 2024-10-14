import 'package:flutter/material.dart';

import '../shared/components/sideBar.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [

        ],
      ),
      drawer:const SideBar(),
      body: const Center(
        child: Text(
          'visualize aqui o estoque',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}
