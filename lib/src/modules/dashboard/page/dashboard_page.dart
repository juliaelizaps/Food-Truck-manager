import 'package:flutter/material.dart';
import 'package:gf/src/modules/dashboard/components/activity_list.dart';
import 'package:gf/src/modules/dashboard/components/bar_graph.dart';
import 'package:gf/src/modules/dashboard/components/dashboard_card.dart';
import 'package:gf/src/modules/dashboard/components/revenue_chart.dart';
import 'package:gf/src/modules/dashboard/services/firebase_service.dart';
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
  double profit = 0.0;

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
    _listenToOrders();
  }

  Future<void> _getDataFromFirebase() async {
    var data = await FirebaseService.getDataFromFirebase();
    setState(() {
      totalOrders = data['totalOrders'];
      revenue = data['revenue'];
      products = data['products'];
      profit = data['profit'];
    });
  }

  void _listenToOrders() {
    FirebaseService.listenToOrders((data) {
      setState(() {
        totalOrders = data['totalOrders'];
        revenue = data['revenue'];
        profit = data['profit'];
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
                  DashboardCard(
                    title: 'Pedidos',
                    value: totalOrders.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    title: 'Receita',
                    value: 'R\$${revenue.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  DashboardCard(
                    title: 'Produtos',
                    value: products.toString(),
                    icon: Icons.store,
                    color: Colors.orange,
                  ),
                  DashboardCard(
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
              const ActivityList(),
              const SizedBox(height: 16),
              //const RevenueChart(),
              const MyBarGraph(weeklySummary:
              [140.0, 120.0, 220.0, 200.0, 150.0, 160.0, 90.0],),
            ],
          ),
        ),
      ),
    );
  }
}
