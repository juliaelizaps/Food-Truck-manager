// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class FirebaseService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   static Future<List> getOrders() async {
//     var ordersSnapshot = await _firestore.collection('Pedidos').get();
//     return ordersSnapshot.docs.map((doc) => Order.fromMap(doc.data())).toList();
//   }
//
//   static Future<void> cancelOrder(String orderId) async {
//     var orderDoc = await _firestore.collection('Pedidos').doc(orderId).get();
//     if (orderDoc.exists) {
//       var orderData = orderDoc.data();
//       if (orderData != null) {
//         await _firestore.collection('PedidosCancelados').doc(orderId).set(orderData);
//         await _firestore.collection('Pedidos').doc(orderId).delete();
//       }
//     }
//   }
// }
