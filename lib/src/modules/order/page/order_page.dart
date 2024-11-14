import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gf/src/modules/order/components/order_form_modal.dart';
import 'package:gf/src/shared/colors/colors.dart';
import '../../../shared/components/red_button.dart';
import '../../../shared/components/sideBar.dart';
import '../../inventory/service/inventory_service.dart';
import '../service/order_service.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Map<String, dynamic>> cart = [];
  FirebaseFirestore bdFirebase = FirebaseFirestore.instance;
  final TextEditingController commentController = TextEditingController();
  final InventoryService inventoryService = InventoryService();
  final OrderService orderService = OrderService();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    setState(() {});
  }

  void addToCart(order_model.OrderProduct product, String comment, List<order_model.OrderProduct> additions) {
    setState(() {
      orderService.addToCart(
        cart,
        product,
        comment,
        additions,
      );
    });
  }

  double calculateTotal() {
    return orderService.calculateTotal(cart);
  }

  Future<void> confirmOrder() async {
    try {
      await orderService.confirmOrder(cart, commentController, inventoryService);
      setState(() {
        cart.clear();
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
        title: const Text('Pedidos'),
      ),
      drawer: const SideBar(),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart_outlined, size: 80),
                  SizedBox(height: 10),
                  Text(
                    'Adicione Produtos ao Carrinho!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
                : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  var item = cart[index];
                  var product = item['product'];
                  var adicionais = item['additional'] as List<Map<String, dynamic>>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Dismissible(
                        key: ValueKey<Map<String, dynamic>>(item),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: AppColors.sweepDeleteColor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 1.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            cart.removeAt(index);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 30,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              "${product['name']} - R\$${product['price']}",
                              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Observação      : ${item['comment']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Adicionais: ${adicionais.map((adicional) => adicional['name']).join(', ')}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: R\$${calculateTotal()}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) {
                            return OrderFormModal(onAddToCart: addToCart);
                          },
                        );
                      },
                      backgroundColor: AppColors.buttonColor,
                      child: const Icon(Icons.add_shopping_cart),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                RedButton(
                  onPressed: confirmOrder,
                  text: 'Confirmar Pedido',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
