import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as model;

class HistoryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<model.Order>> getCancelledOrders() async {
    var ordersSnapshot = await _firestore
        .collection('Pedidos Cancelados')
        .orderBy('createdAt', descending: true)
        .get();
    return ordersSnapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }

}