import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Sistema GFE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Ação ao clicar no botão Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                // Ação ao clicar no botão Dashboard
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Cardápio'),
              onTap: () {
                // Ação ao clicar no botão Cardápio
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Produtos'),
              onTap: () {
                // Ação ao clicar no botão Produtos
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Pedidos'),
              onTap: () {
                // Ação ao clicar no botão Pedidos
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico de Pedidos'),
              onTap: () {
                // Ação ao clicar no botão Histórico de Pedidos
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Estoque'),
              onTap: () {
                // Ação ao clicar no botão Estoque
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Ação ao clicar no botão Logout
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bem-vindo à Home Page!'),
      ),
    );
  }
}
