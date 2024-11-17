import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'package:gf/src/shared/components/sideBar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int totalOrders = 0;
  double revenue = 0.0;
  int products = 0;
  double profit = 0.0; // Adicionando um campo para lucro.

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
    _listenToOrders();
  }

  Future<void> _getDataFromFirebase() async {
    try {
      var ordersSnapshot = await _firestore.collection('Pedidos').get();
      double totalRevenue = 0.0;
      int orderCount = ordersSnapshot.size;

      for (var orderDoc in ordersSnapshot.docs) {
        var orderData = orderDoc.data();
        var productsList = orderData['products'] as List<dynamic>;

        double orderTotal = 0.0;
        for (var product in productsList) {
          var price = product['price']?.toDouble() ?? 0.0;
          orderTotal += price;
        }

        totalRevenue += orderTotal;
      }

      var productsSnapshot = await _firestore.collection('Produtos').get();
      int productCount = productsSnapshot.size;

      // Simulação de cálculo de lucro.
      double simulatedProfit = totalRevenue * 0.3;

      setState(() {
        revenue = totalRevenue;
        totalOrders = orderCount;
        products = productCount;
        profit = simulatedProfit;
      });
    } catch (e) {
      print('Erro ao buscar dados do Firebase: $e');
    }
  }

  void _listenToOrders() {
    _firestore.collection('Pedidos').snapshots().listen((snapshot) {
      double totalRevenue = 0.0;
      int orderCount = snapshot.size;

      for (var orderDoc in snapshot.docs) {
        var orderData = orderDoc.data();
        var productsList = orderData['products'] as List<dynamic>;

        double orderTotal = 0.0;
        for (var product in productsList) {
          var price = product['price']?.toDouble() ?? 0.0;
          orderTotal += price;
        }

        totalRevenue += orderTotal;
      }

      // Simulação de cálculo de lucro.
      double simulatedProfit = totalRevenue * 0.3;

      setState(() {
        revenue = totalRevenue;
        totalOrders = orderCount;
        profit = simulatedProfit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Visão Geral',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDashboardCard(
                    title: 'Pedidos',
                    value: totalOrders.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  _buildDashboardCard(
                    title: 'Receita',
                    value: 'R\$${revenue.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  _buildDashboardCard(
                    title: 'Produtos',
                    value: products.toString(),
                    icon: Icons.store,
                    color: Colors.orange,
                  ),
                  _buildDashboardCard(
                    title: 'Lucro Estimado',
                    value: 'R\$${profit.toStringAsFixed(2)}',
                    icon: Icons.show_chart,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Atividades Recentes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildActivityList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.initialPageBackground,
            child: const Icon(Icons.event, color: Colors.white),
          ),
          title: Text('Atividade ${index + 1}'),
          subtitle: Text('Detalhes da atividade ${index + 1}'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        );
      },
    );
  }
}
