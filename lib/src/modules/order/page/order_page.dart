import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/components/sideBar.dart';
import '../components/order_form_modal.dart';

/*
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final FirebaseFirestore bdFirebase = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> cart = []; // Lista de produtos no carrinho
  final TextEditingController commentController = TextEditingController();

  void adicionarAoCarrinho(Map<String, dynamic> produto, String comentario, List<String> adicionais) {
    setState(() {
      cart.add({
        'product': produto,
        'comentario': comentario,
        'adicionais': adicionais,
      });
    });
  }

  double calcularTotal() {
    double total = 0;
    for (var item in cart) {
      total += item['product']['price'];
      // Adicione lógica para somar os preços dos adicionais, se necessário
    }
    return total;
  }

  Future<void> confirmarPedido() async {
    try {
      for (var item in cart) {
        var produto = item['product'];
        List<String> itemIds = List<String>.from(produto['itemIds']);
        for (var itemId in itemIds) {
          int quantidade = 1; // Defina a quantidade conforme necessário
          //await decrementarEstoque(bdFirebase, itemId, quantidade);
        }
      }

      var orderId = Uuid().v1();
      var newOrder = Order(
        id: orderId,
        comment: commentController.text, // Adiciona comentário ao pedido
        products: cart,
        total: calcularTotal(),
        createdAt: DateTime.now(),
      );
      await bdFirebase.collection("Pedidos").doc(orderId).set(newOrder.toMap());

      setState(() {
        cart.clear();
        commentController.clear(); // Limpa o campo de comentário
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pedido confirmado com sucesso!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao confirmar pedido: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
      ),
      drawer: const SideBar(), // Adicionado o SideBar aqui
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                var item = cart[index];
                var produto = item['product'];
                return ListTile(
                  title: Text("${produto['name']} - R\$${produto['price']}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Comentário: ${item['comentario']}"),
                      Text("Adicionais: ${item['adicionais'].join(', ')}"),
                    ],
                  ),
                );
              },
            ),
          ),
          Text("Total: R\$${calcularTotal()}"),
          ElevatedButton(
            onPressed: confirmarPedido,
            child: Text("Confirmar Pedido"),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                builder: (context) {
                  return OrderFormModal(onAddToCart: adicionarAoCarrinho);
                },
              );
            },
            child: Text("Adicionar Produto"),
          ),
        ],
      ),
    );
  }
}
*/