import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;

class OrderFormModal extends StatefulWidget {
  final Function(order_model.OrderProduct, String, List<order_model.OrderProduct>) onAddToCart;

  const OrderFormModal({required this.onAddToCart});

  @override
  _OrderFormModalState createState() => _OrderFormModalState();
}

class _OrderFormModalState extends State<OrderFormModal> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String comentarioProduto = "";
  List<order_model.OrderProduct> adicionaisProduto = [];
  order_model.OrderProduct? produtoSelecionado;
  List<order_model.OrderProduct> produtos = [];

  @override
  void initState() {
    super.initState();
    fetchProdutos();
  }

  Future<void> fetchProdutos() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Produtos').get();
    setState(() {
      produtos = snapshot.docs.map((doc) => order_model.OrderProduct.fromMap(doc.data()!)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text("Adicionar Produto", style: Theme.of(context).textTheme.headline5),
          DropdownButtonFormField<order_model.OrderProduct>(
            decoration: const InputDecoration(labelText: "Selecionar Produto"),
            items: produtos.map((produto) {
              return DropdownMenuItem<order_model.OrderProduct>(
                value: produto,
                child: Text(produto.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                produtoSelecionado = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: "Observação"),
            onChanged: (value) {
              setState(() {
                comentarioProduto = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Selecionar Adicional"),
            items: produtos.map((produto) {
              return DropdownMenuItem<String>(
                value: produto.id,
                child: Text(produto.name),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null && !adicionaisProduto.any((produto) => produto.id == newValue)) {
                setState(() {
                  var matchedProduct = produtos.firstWhere((produto) => produto.id == newValue);
                  adicionaisProduto.add(matchedProduct);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            children: adicionaisProduto.map((produto) {
              return Chip(
                label: Text(produto.name),
                onDeleted: () {
                  setState(() {
                    adicionaisProduto.remove(produto);
                  });
                },
              );
            }).toList(),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (produtoSelecionado != null) {
                    widget.onAddToCart(
                      produtoSelecionado!,
                      comentarioProduto,
                      adicionaisProduto,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Adicionar ao Carrinho"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
