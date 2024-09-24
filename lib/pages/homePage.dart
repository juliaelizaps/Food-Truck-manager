import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:gf/pages/dashboardPage.dart';
import 'package:gf/pages/productPage.dart';
import 'package:gf/pages/orderPage.dart';
import 'package:gf/pages/historyPage.dart';
import 'package:gf/pages/inventoryPage.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo_GF.png',
                    height: 100,
                  ),
                  const SizedBox(width: 30), // Espaço entre a imagem e o texto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Gerenciador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'de vendas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const DashboardPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProductPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Pedidos'),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderPage()),
               );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico de Pedidos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const HistoryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Estoque'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InventoryPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar Logout'),
                      content: const Text('Você realmente deseja sair?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text('Sim'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Resumo do Dia'),
                subtitle: const Text('Total de Vendas: R\$ 500,00\nPedidos: 20\nItens Mais Vendidos: Hambúrguer, Batata Frita'),
                leading: const Icon(Icons.assessment),
                onTap: () {
                  // Ação ao clicar no resumo do dia
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Notificações'),
                subtitle: const Text('2 itens de estoque baixo\n1 pedido pendente'),
                leading: const Icon(Icons.notifications),
                onTap: () {
                  // Ação ao clicar nas notificações
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Atualizações'),
                subtitle: const Text('Histórico semanal:Gerado com sucesso!\nHistórico mensal:Gerado com sucesso!'),
                leading: const Icon(Icons.history),
                onTap: () {
                  // Ação ao clicar nas notificações
                },
              ),
            ),
            // Adicione mais cards conforme necessário...
          ],
        ),
      ),
    );
  }
}
