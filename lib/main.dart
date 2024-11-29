import 'package:flutter/material.dart';
import 'package:gf/src/modules/Account/page/account_page.dart';
import 'package:gf/src/modules/List/page/list_page.dart';
import 'package:gf/src/modules/history/pages/history_page.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'src/modules/dashboard/page/dashboard_page.dart';
import 'src/modules/List/page/list_page.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/modules/inventory/page/inventory_page.dart';
import 'src/modules/login/page/login_page.dart';
import 'src/modules/order/page/order_page.dart';
import 'src/modules/product/page/product_page.dart';
import 'src/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  }


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Gerencie',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.initialPageBackground,
        ),
      ),
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.login: (context) => const LoginPage(),
        AppRouter.home: (context) => const AccountPage(),
        AppRouter.dashboard: (context) => const DashboardPage(),
        AppRouter.product: (context) => const ProductPage(),
        AppRouter.orders: (context) => const OrderPage(),
        AppRouter.list: (context) => const ListPage(),
        AppRouter.history: (context) => const HistoryPage(),
        AppRouter.inventory: (context) => const InventoryPage(),
      },
    );
  }
}




