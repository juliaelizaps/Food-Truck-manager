import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../../inventory/service/inventory_service.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;

class OrderService {
  late FirebaseFirestore bdFirebase;

  OrderService({FirebaseFirestore? firestore}){
    (firestore != null)? bdFirebase = firestore : bdFirebase = FirebaseFirestore.instance;
  }

  Future<void> addToCart(
      List<Map<String, dynamic>> cart,
      order_model.OrderProduct product,
      String comment,
      List<order_model.OrderProduct> additions) async {
    cart.add({
      'product': product.toMap(),
      'comment': comment,
      'additional': additions.map((addition) => addition.toMap()).toList(),
    });
  }

  double calculateTotal(List<Map<String, dynamic>> cart) {
    double total = 0;
    for (var item in cart) {
      total += item['product']['price'];
      var additions = item['additional'] as List<Map<String, dynamic>>;
      for (var addition in additions) {
        total += addition['price'];
      }
    }
    return total;
  }

  Future<void> confirmOrder(
      List<Map<String, dynamic>> cart,
      TextEditingController commentController,
      InventoryService inventoryService) async {
    if (cart.isEmpty) {
      throw Exception("O carrinho está vazio!");
    }

    for (var item in cart) {
      var product = item['product'];
      List<String> itemIds = List<String>.from(product['itemIds'] ?? []);
      for (var itemId in itemIds) {
        int quantity = 1; // Definir a quantidade necessário pra cada um depois
        await inventoryService.decrementStock(itemId, quantity);
      }
    }

    var orderId = const Uuid().v1();
    var newOrder = order_model.Order(
      id: orderId,
      comment: commentController.text,
      products: cart.map((item) => order_model.OrderProduct.fromMap({
        ...item['product'],
        'comment': item['comment'],
        'additions': item['additions'],
      })).toList(),
      total: calculateTotal(cart),
      createdAt: DateTime.now(),
    );

    await bdFirebase.collection("Pedidos").doc(orderId).set(newOrder.toMap());

    cart.clear();
    commentController.clear();
  }
}
