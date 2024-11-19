import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;

class ChartService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, double>> getRevenueByPeriod(String period) async {
    var ordersSnapshot = await _firestore.collection('Pedidos').get();
    Map<String, double> revenueData = {};
    for (var doc in ordersSnapshot.docs) {
      var orders = order_model.Order.fromMap(doc.data());
      var date = orders.createdAt;
      String key;
      switch (period) {
        case 'Diário':
          key = '${date.day}/${date.month}/${date.year}';
          break;
        case 'Semanal':
          key = 'Sem ${_getWeekOfYear(date)}';
          break;
        case 'Mensal':
        default:
          key = '${date.month}/${date.year}';
          break;
      }
      if (!revenueData.containsKey(key)) {
        revenueData[key] = 0.0;
      }
      revenueData[key] = revenueData[key]! + orders.total;
    }
    return revenueData;
  }

  static int _getWeekOfYear(DateTime date) {
    var firstDayOfYear = DateTime(date.year, 1, 1);
    var daysSinceStartOfYear = date.difference(firstDayOfYear).inDays;
    return (daysSinceStartOfYear / 7).ceil();
  }
}
