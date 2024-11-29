import 'package:flutter/material.dart';
import 'package:gf/src/shared/components/red_button.dart';

deleteOrderDialog({
  required BuildContext context,
  required String orderId,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Deseja realmente excluir este pedido?"),
        actions: [
          RedButton(
            text: "Excluir Pedido",
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
