import 'package:flutter/material.dart';

import '../../../shared/components/sideBar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [

        ],
      ),
      drawer:const SideBar(),
      body: const Center(
        child: Text(
          'Bem-vindo ao Dashboard!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}
