import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;

class ListService {
  static final FirebaseFirestore _dbfirestore = FirebaseFirestore.instance;

  static Future<List<model.Order>> getOrders() async {
    try {
      var ordersSnapshot = await _dbfirestore
          .collection('Pedidos')
          .where("status", isEqualTo: "IN_PROGRESS")
          .orderBy('createdAt', descending: true)
          .get();
      print("Quantidade de pedidos obtidos: ${ordersSnapshot.docs.length}");
      for (var doc in ordersSnapshot.docs){
        print("Pedido: ${doc.data()}");
      }
      return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
    } catch (e) {
      print("Erro ao carregar pedidos: $e");
      return [];
    }
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    await _dbfirestore.collection('Pedidos').doc(orderId).update({'status': status});
  }

  static Future<List<model.Order>> getCancelledOrders() async {
    var ordersSnapshot = await _dbfirestore
        .collection('Pedidos Cancelados')
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }

  static Future<void> cancelOrder(String orderId) async {
    var orderDoc = await _dbfirestore.collection('Pedidos').doc(orderId).get();
    if (orderDoc.exists) {
      var orderData = orderDoc.data();
      if (orderData != null) {
        await _dbfirestore.collection('Pedidos Cancelados').doc(orderId).set(orderData);
        await _dbfirestore.collection('Pedidos').doc(orderId).delete();
      }
    }
  }
}
