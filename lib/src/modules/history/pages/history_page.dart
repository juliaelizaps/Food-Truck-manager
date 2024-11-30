import 'package:flutter/material.dart';
import 'package:gf/src/modules/history/components/delete_orders_dialog.dart';
import 'package:gf/src/modules/history/services/history_service.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;
import 'package:gf/src/shared/colors/colors.dart';
import 'package:gf/src/shared/components/sideBar.dart';
import 'package:intl/intl.dart' show DateFormat;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<model.Order>> _dbfutureOrders;
  String _selectedCategory = 'Todos';
  Set<String> _cancelledOrderIds = {};

  @override
  void initState() {
    super.initState();
    _dbfutureOrders = HistoryService.getAllOrders();
    _loadCancelledOrders();
  }

  void _loadCancelledOrders() async {
    var cancelledOrders = await HistoryService.getCancelledOrders();
    setState(() {
      _cancelledOrderIds = cancelledOrders.map((order) => order.id).toSet();
    });
  }

  void _onCategoryChanged(String? value) {
    setState(() {
      _selectedCategory = value!;
      if (_selectedCategory == 'Cancelados') {
        _dbfutureOrders = HistoryService.getCancelledOrders();
      } else if (_selectedCategory == 'Todos') {
        _dbfutureOrders = HistoryService.getAllOrders();
      } else if (_selectedCategory == 'Finalizados') {
        _dbfutureOrders = HistoryService.getFinishedOrders();
      } else if (_selectedCategory == 'Em andamento') {
        _dbfutureOrders = HistoryService.getInProgressOrders();
      }
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  Widget _buildStatusChip(String status) {
    String label = '';
    Color color = Colors.grey;

    if (status == 'FINISHED') {
      label = 'Finalizado';
      color = Colors.green;
    } else if (status == 'IN_PROGRESS') {
      label = 'Em andamento';
      color = Colors.blue;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pedidos'),
      ),
      drawer: const SideBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Categoria de pedidos:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: AppColors.buttonColor,
                      iconEnabledColor: Colors.white,
                      value: _selectedCategory,
                      onChanged: _onCategoryChanged,
                      items: <String>['Todos', 'Em andamento', 'Finalizados', 'Cancelados']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white), // Cor dos itens do dropdown
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<model.Order>>(
              future: _dbfutureOrders,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar pedidos.'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum pedido encontrado.'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var order = snapshot.data![index];
                    var textColor = _cancelledOrderIds.contains(order.id) ? Colors.red : Colors.black;
                    return ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatusChip(order.status),
                          const SizedBox(height: 1.0),
                          Text(
                            'Total do Pedido: R\$${order.total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,  // Define a cor do texto
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(formatDateTime(order.createdAt)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.buttonColor),
                        onPressed: () {
                          deleteOrderDialog(
                            context: context,
                            orderId: order.id,
                            onDelete: () async {
                              await HistoryService.deleteOrder(order.id);
                              setState(() {
                                _dbfutureOrders = HistoryService.getCancelledOrders();
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
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
