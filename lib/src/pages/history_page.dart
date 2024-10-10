import 'package:flutter/material.dart';

import '../ widgets/sideBar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: const [],
      ),
      drawer:const SideBar(),
      body: const Center(
        child: Text(
          'visualize aqui o histórico de pedidos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}