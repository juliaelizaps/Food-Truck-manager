import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../shared/colors.dart';
import 'logout_widget.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(90),
        bottomRight: Radius.circular(0),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.initialPageBackground,
                borderRadius: BorderRadius.only(
                  //topRight: Radius.circular(50),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/chapeu-de-chef.png',
                    height: 100,
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'GERENCIE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Bem-vindo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: AppColors.sideBarIcons),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: AppColors.sideBarIcons),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.dashboard);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: AppColors.sideBarIcons),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.product);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt, color: AppColors.sideBarIcons),
              title: const Text('Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.orders);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.sideBarIcons),
              title: const Text('Histórico de Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.history);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory, color: AppColors.sideBarIcons),
              title: const Text('Estoque'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.inventory);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.sideBarIcons),
              title: const Text('Logout'),
              onTap: () {
                LogoutWidget.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
