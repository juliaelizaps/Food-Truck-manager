import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class ExamplePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Example Page'),
    ),
    body: Center(
      child: RedButton(
        label: 'Adicionar item',
        onPressed: () {
          // Adicione sua lógica aqui
          if (true) { // Substitua 'true' pela condição
            //lógica aqui
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Item Adicionado'),
                  content: const Text('Você adicionou um item com sucesso!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    ),
  );
}
}


