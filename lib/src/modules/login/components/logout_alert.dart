import 'package:flutter/material.dart';
import 'package:gf/src/modules/login/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class LogoutWidget {
  static void showLogoutDialog(BuildContext context) {
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
              onPressed: () async {
                await AuthService().logout();
                Navigator.of(context).pushReplacementNamed(AppRouter.login);

              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
