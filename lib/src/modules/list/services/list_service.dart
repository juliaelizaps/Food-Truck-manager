import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;

class ListService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<model.Order>> getOrders() async {
    var ordersSnapshot = await _firestore
        .collection('Pedidos')
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }

  static Future<List<model.Order>> getCancelledOrders() async {
    var ordersSnapshot = await _firestore
        .collection('Pedidos Cancelados')
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }

  static Future<void> cancelOrder(String orderId) async {
    var orderDoc = await _firestore.collection('Pedidos').doc(orderId).get();
    if (orderDoc.exists) {
      var orderData = orderDoc.data();
      if (orderData != null) {
        await _firestore.collection('Pedidos Cancelados').doc(orderId).set(orderData);
        await _firestore.collection('Pedidos').doc(orderId).delete();
      }
    }
  }
}
