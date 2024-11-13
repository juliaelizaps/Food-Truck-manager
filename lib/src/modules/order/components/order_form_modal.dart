import 'package:flutter/material.dart';

class OrderFormModal extends StatefulWidget {
  final Function(Map<String, dynamic>, String, List<String>) onAddToCart;

  OrderFormModal({required this.onAddToCart});

  @override
  _OrderFormModalState createState() => _OrderFormModalState();
}

class _OrderFormModalState extends State<OrderFormModal> {
  String comentarioProduto = "";
  List<String> adicionaisProduto = [];
  String? produtoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text("Adicionar Produto", style: Theme.of(context).textTheme.headline5),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Selecionar Produto"),
            items: [
              DropdownMenuItem<String>(
                value: "produto1",
                child: Text("Produto 1"),
              ),
              DropdownMenuItem<String>(
                value: "produto2",
                child: Text("Produto 2"),
              ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                produtoSelecionado = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: "Comentário"),
            onChanged: (value) {
              setState(() {
                comentarioProduto = value;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: "Adicionais"),
            onChanged: (value) {
              setState(() {
                adicionaisProduto = value.split(',').map((item) => item.trim()).toList();
              });
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (produtoSelecionado != null) {
                    widget.onAddToCart(
                      {'name': produtoSelecionado, 'price': 10.0, 'itemIds': ['item1']},
                      comentarioProduto,
                      adicionaisProduto,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("Adicionar ao Carrinho"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
