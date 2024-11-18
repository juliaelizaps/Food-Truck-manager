// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gf/src/modules/history/services/history_service.dart';
//
//
// class HistoryPage extends StatefulWidget {
//   const HistoryPage({Key? key}) : super(key: key);
//
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }
//
// class _HistoryPageState extends State<HistoryPage> {
//   late Future<List<Order>> _futureOrders;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureOrders = FirebaseService.getOrders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Histórico de Pedidos'),
//       ),
//       body: FutureBuilder<List<Order>>(
//         future: _futureOrders,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('Erro ao carregar pedidos.'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Nenhum pedido encontrado.'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               var order = snapshot.data![index];
//               return ListTile(
//                 title: Text('Pedido ${order.id}'),
//                 subtitle: Text('Total: R\$${order.total.toStringAsFixed(2)}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButton<String>(
//                       items: const [
//                         DropdownMenuItem(value: 'Em Andamento', child: Text('Em Andamento')),
//                         DropdownMenuItem(value: 'Finalizado', child: Text('Finalizado')),
//                         DropdownMenuItem(value: 'Cancelado', child: Text('Cancelado')),
//                       ],
//                       onChanged: (value) {
//                         if (value != null) {
//                           // Atualiza o status do pedido no Firebase
//                           FirebaseFirestore.instance.collection('Pedidos').doc(order.id).update({
//                             'status': value,
//                           });
//                         }
//                       },
//                       hint: const Text('Status'),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () {
//                         FirebaseService.cancelOrder(order.id);
//                         setState(() {
//                           _futureOrders = FirebaseService.getOrders();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
