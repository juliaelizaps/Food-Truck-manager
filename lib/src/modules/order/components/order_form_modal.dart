import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;

import '../../../shared/components/red_button.dart';

class OrderFormModal extends StatefulWidget {
  final Function(order_model.OrderProduct, String, List<order_model.OrderProduct>) onAddToCart;

  const OrderFormModal({required this.onAddToCart});

  @override
  _OrderFormModalState createState() => _OrderFormModalState();
}

class _OrderFormModalState extends State<OrderFormModal> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String productObservation = "";
  List<order_model.OrderProduct> additionalProduct = [];
  order_model.OrderProduct? selectedProduct;
  List<order_model.OrderProduct> products = [];

  @override
  void initState() {
    super.initState();
    fetchProdutos();
  }

  Future<void> fetchProdutos() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Produtos').get();
    setState(() {
      products = snapshot.docs.map((doc) => order_model.OrderProduct.fromMap(doc.data())).toList();
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
            items: products.map((produto) {
              return DropdownMenuItem<order_model.OrderProduct>(
                value: produto,
                child: Text(produto.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedProduct = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: "Observação"),
            onChanged: (value) {
              setState(() {
                productObservation = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Selecionar Adicional"),
            items: products.map((produto) {
              return DropdownMenuItem<String>(
                value: produto.id,
                child: Text(produto.name),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null && !additionalProduct.any((produto) => produto.id == newValue)) {
                setState(() {
                  var matchedProduct = products.firstWhere((produto) => produto.id == newValue);
                  additionalProduct.add(matchedProduct);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            //constraints: const BoxConstraints(maxHeight: 200),
            child: ListView(
              //shrinkWrap: true,
              children: additionalProduct.map((produto) {
                return Chip(
                  label: Text(produto.name),
                  onDeleted: () {
                    setState(() {
                      additionalProduct.remove(produto);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          //const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("Cancelar"),
              ),
              RedButton(
                onPressed: () {
                  if (selectedProduct != null) {
                    widget.onAddToCart(
                      selectedProduct!,
                      productObservation,
                      additionalProduct,
                    );
                    Navigator.pop(context);
                  }
                },
                text: 'Adicionar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
