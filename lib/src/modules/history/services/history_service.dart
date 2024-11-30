import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;

class HistoryService {
  static final FirebaseFirestore _dbfirestore = FirebaseFirestore.instance;

  static Future<List<model.Order>> getCancelledOrders() async {
    var ordersSnapshot = await _dbfirestore
        .collection('Pedidos Cancelados')
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }

  static Future<void> deleteOrder(String orderId) async {
            await _dbfirestore.collection('Pedidos Cancelados').doc(orderId).delete();
            await _dbfirestore.collection('Pedidos').doc(orderId).delete();
  }
  static Future<List<model.Order>> getAllOrders() async {
    var ordersSnapshot = await _dbfirestore
        .collection('Pedidos')
        .orderBy('createdAt', descending: true)
        .get(); var cancelledOrdersSnapshot = await _dbfirestore
        .collection('Pedidos Cancelados')
        .orderBy('createdAt', descending: true)
        .get();
        var orders = ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
        var cancelledOrders = cancelledOrdersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
        orders.addAll(cancelledOrders);
        return orders;
  }

  static Future<List<model.Order>> getFinishedOrders() async {
    var ordersSnapshot = await _dbfirestore
        .collection('Pedidos')
        .where("status", isEqualTo: "FINISHED")
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }
  static Future<List<model.Order>> getInProgressOrders() async {
    var ordersSnapshot = await _dbfirestore
        .collection('Pedidos')
        .where("status", isEqualTo: "IN_PROGRESS")
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }
}