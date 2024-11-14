import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryService {
  final FirebaseFirestore bdFirebase = FirebaseFirestore.instance;

  Future<void> decrementStock(String itemId, int quantidade) async {
    var docRef = bdFirebase.collection('Estoque').doc(itemId);
    await bdFirebase.runTransaction((transaction) async {
      var docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        var newStock = docSnapshot['stock'] - quantidade;
        transaction.update(docRef, {'stock': newStock});
      }
    });
  }
}
