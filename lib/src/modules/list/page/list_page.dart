import 'package:flutter/material.dart';
import 'package:gf/src/modules/List/services/list_service.dart';
import 'package:gf/src/modules/list/components/cancel_orders_dialog.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;
import 'package:gf/src/shared/colors/colors.dart';
import 'package:gf/src/shared/components/sideBar.dart';
import 'package:intl/intl.dart' show DateFormat;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<model.Order>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = ListService.getOrders();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
  void _updateOrderStatus(String orderId, String status) async {
    await ListService.updateOrderStatus(orderId, status);
    setState(() {
      _futureOrders = ListService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
      ),
      drawer: const SideBar(),
      body: FutureBuilder<List<model.Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print("Quantidade de pedidos na UI: ${snapshot.data!.length}");
            return Center(child: Text('Erro ao carregar pedidos.${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var order = snapshot.data![index];
              return Dismissible(
                key: Key(order.id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction){
                  _updateOrderStatus(order.id, 'FINISHED');
                },
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                      Icons.check_circle,
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    borderRadius:BorderRadius.circular(5.0),
                  ),
                  child: ExpansionTile(
                    title: Text('Total do Pedido: R\$${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold,
                      ),),
                    subtitle: Text(formatDateTime(order.createdAt)),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: AppColors.buttonColor),
                      onPressed: () {
                        cancelOrderDialog(
                          context: context,
                          orderId: order.id,
                          onDelete: () async {
                            await ListService.cancelOrder(order.id);
                            setState(() {
                              _futureOrders = ListService.getOrders();
                            });
                          },
                        );
                      },
                    ),
                    children: [
                      ...order.products.map((product) {
                        var additions = product.additions.map((add) => add['name']).join(', ');
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.comment.isNotEmpty) Text("Observação: ${product.comment}"),
                              if (product.additions.isNotEmpty) Text("Adicionais: $additions"),
                              Text("Preço: R\$${product.price.toStringAsFixed(2)}"),
                            ],
                          ),
                        );
                      }).toList(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'Total do Pedido: R\$${order.total.toStringAsFixed(2)}',
                      //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
