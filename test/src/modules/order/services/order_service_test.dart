import 'package:flutter_test/flutter_test.dart';
import 'package:gf/src/modules/order/services/order_service.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/order/model/order_model.dart' as order_model;
// import 'order_service_test.mocks.dart';
//
// @GenerateNiceMocks([MockSpec<FirebaseFirestore>()])
// void main (){
//   group('OrderServices', () {
//     test('O metodo addToCart deve adicionar um produto ao carrinho', () {
//       MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
//
//       OrderService orderService = OrderService(firestore: mockFirebaseFirestore);
//
//       list<Map<String, dynamic>> cart = [];
//       var product = order_model.OrderProduct(
//         id: '1',
//         name: 'Produto Teste',
//         price: 10.0,
//       );
//       var comment = 'Este é um comentário de teste';
//       list<order_model.OrderProduct> additions = [];
//
//       orderService.addToCart(cart, product, comment, additions);
//
//       expect(cart.length, 1);
//       expect(cart[0]['product']['id'], '1');
//       expect(cart[0]['product']['name'], 'Produto Teste');
//       expect(cart[0]['product']['price'], 10.0);
//       expect(cart[0]['comment'], 'Este é um comentário de teste');
//       expect(cart[0]['additional'], []);
//     });
//   });
// }
