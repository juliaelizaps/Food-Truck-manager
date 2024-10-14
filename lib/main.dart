import 'package:flutter/material.dart';
import 'package:gf/src/modules/home/page/home_page.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'src/modules/dashboard/page/dashboard_page.dart';
import 'src/modules/history/page/history_page.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/modules/inventory/page/inventory_page.dart';
import 'src/modules/login/page/login_page.dart';
import 'src/modules/order/page/order_page.dart';
import 'src/modules/product/page/product_page.dart';
import 'src/routes/app_routes.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.initialPageBackground,
        ),
      ),
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.login: (context) => const LoginPage(),
        AppRouter.home: (context) => const HomePage(),
        AppRouter.dashboard: (context) => const DashboardPage(),
        AppRouter.product: (context) => const ProductPage(),
        AppRouter.orders: (context) => const OrderPage(),
        AppRouter.history: (context) => const HistoryPage(),
        AppRouter.inventory: (context) => const InventoryPage(),
      },
    );
  }
}




