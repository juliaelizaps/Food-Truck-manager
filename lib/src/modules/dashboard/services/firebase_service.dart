import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>> getDataFromFirebase() async {
    try {
      var ordersSnapshot = await _firestore.collection('Pedidos').get();
      double totalRevenue = 0.0;
      int orderCount = ordersSnapshot.size;

      for (var orderDoc in ordersSnapshot.docs) {
        var orderData = orderDoc.data();
        var productsList = orderData['products'] as List<dynamic>;

        double orderTotal = 0.0;
        for (var product in productsList) {
          var price = product['price']?.toDouble() ?? 0.0;
          orderTotal += price;
        }

        totalRevenue += orderTotal;
      }

      var productsSnapshot = await _firestore.collection('Produtos').get();
      int productCount = productsSnapshot.size;

      double simulatedProfit = totalRevenue * 0.3;

      return {
        'totalOrders': orderCount,
        'revenue': totalRevenue,
        'products': productCount,
        'profit': simulatedProfit,
      };
    } catch (e) {
      print('Erro ao buscar dados do Firebase: $e');
      return {};
    }
  }

  static void listenToOrders(Function(Map<String, dynamic>) onUpdate) {
    _firestore.collection('Pedidos').snapshots().listen((snapshot) {
      double totalRevenue = 0.0;
      int orderCount = snapshot.size;

      for (var orderDoc in snapshot.docs) {
        var orderData = orderDoc.data();
        var productsList = orderData['products'] as List<dynamic>;

        double orderTotal = 0.0;
        for (var product in productsList) {
          var price = product['price']?.toDouble() ?? 0.0;
          orderTotal += price;
        }

        totalRevenue += orderTotal;
      }

      /// Simula o cálculo de lucro.
      double simulatedProfit = totalRevenue * 0.3;

      onUpdate({
        'totalOrders': orderCount,
        'revenue': totalRevenue,
        'profit': simulatedProfit,
      });
    });
  }
}
