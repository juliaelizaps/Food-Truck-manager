import 'package:flutter/material.dart';
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
  late Future<List<model.Order>> _futureOrders;
  String _selectedCategory = 'Cancelados';

  @override
  void initState() {
    super.initState();
    _futureOrders = HistoryService.getCancelledOrders();
  }

  void _onCategoryChanged(String? value) {
    setState(() {
      _selectedCategory = value!;
      if (_selectedCategory == 'Cancelados') {
        _futureOrders = HistoryService.getCancelledOrders();
      } else {
        _futureOrders = Future.value([]); // Placeholder para "Finalizados"
      }
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
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
                    color: AppColors.buttonColor, // Cor do fundo do botão
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.red, // Cor de fundo do dropdown
                      iconEnabledColor: Colors.black, // Cor do ícone do dropdown
                      value: _selectedCategory,
                      onChanged: _onCategoryChanged,
                      items: <String>['Cancelados', 'Finalizados']
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
              future: _futureOrders,
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
                    return ExpansionTile(
                      title: Text('Total do Pedido: R\$${order.total.toStringAsFixed(2)} => ${formatDateTime(order.createdAt)}'),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Total do Pedido: R\$${order.total.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
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
