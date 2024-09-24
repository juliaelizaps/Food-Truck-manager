import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class ExamplePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Example Page'),
    ),
    body: Center(
      child: RedButton(
        label: 'Adicionar item',
        onPressed: () {
          // Adicione sua lógica aqui
          if (true) { // Substitua 'true' pela sua condição
            // Sua lógica aqui
            print('Botão pressionado!');
            // Exemplo: Mostrar um diálogo
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Item Adicionado'),
                  content: Text('Você adicionou um item com sucesso!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
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


