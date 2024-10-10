import 'package:flutter/material.dart';
import 'package:gf/src/pages/dashboard_page.dart';
import 'package:gf/src/pages/history_page.dart';
import 'package:gf/src/pages/home_page.dart';
import 'package:gf/src/pages/inventory_page.dart';
import 'package:gf/src/pages/login_page.dart';
import 'package:gf/src/%20widgets/logout_widget.dart';
import 'package:gf/src/pages/order_Page.dart';
import 'package:gf/src/pages/product_Page.dart';
import 'package:gf/src/shared/colors.dart';
import 'src/pages/initial_page.dart';
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
        AppRouter.login: (context) => LoginPage(),
        AppRouter.home: (context) => const HomePage(),
        AppRouter.dashboard: (context) => const DashboardPage(),
        AppRouter.product: (context) => const ProductPage(),
        AppRouter.orders: (context) => const OrderPage(),
        AppRouter.history: (context) => const HistoryPage(),
        AppRouter.inventory: (context) => const InventoryPage(),
      },
      //ExamplePage(),
    );
  }
}




