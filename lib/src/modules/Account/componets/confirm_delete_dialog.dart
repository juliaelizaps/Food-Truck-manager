import 'package:flutter/material.dart';
import 'package:gf/src/modules/login/services/auth_service.dart';
import 'package:gf/src/shared/components/red_button.dart';

import '../../../routes/app_routes.dart';

showDeleteConfirmationDialog({
  required BuildContext context,
  required String email,
  }){
  showDialog(
      context: context,
      builder: (context){
        TextEditingController confirmPasswordController = TextEditingController();
    return AlertDialog(
      title: Text("Deseja realmente excluir sua conta? $email"),
      content: SizedBox(
        height: 170,
        child: Column(
          children: [
            const Text('Para excluir a conta, insira sua senha:'),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(label: Text("Senha")),
            )
          ],
        ),
      ),
      actions: [
        RedButton(
          text:("Excluir Conta"),
            onPressed: (){
            AuthService()
                .removeUser(password: confirmPasswordController.text).then((String? error){
                  if(error == null){
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed(AppRouter.login);
                  }
            } );
            },
        )
      ],
    );
  });
}