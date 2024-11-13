import 'package:flutter/material.dart';
import 'package:gf/src/modules/product/components/product_form_modal.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'package:gf/src/shared/components/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gf/src/modules/inventory/model/inventory_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> listProducts = [];
  FirebaseFirestore bdFirebase = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<Map<String, String>> getInventoryNames(List<String> itemIds) async {
    Map<String, String> inventoryNames = {};
    for (String itemId in itemIds) {
      var doc = await bdFirebase.collection('Estoque').doc(itemId).get();
      if (doc.exists) {
        Inventory item = Inventory.fromMap(doc.data()!);
        inventoryNames[itemId] = item.name;
      }
    }
    return inventoryNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      drawer: const SideBar(),
      body: (listProducts.isEmpty) ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
                Icons.production_quantity_limits,
                size: 80
            ),
            SizedBox(height: 10),
            Text(
              'Cadastre Produtos!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ) : RefreshIndicator(
        onRefresh: () {
          return refresh();
        },
        child: ListView.builder(
          itemCount: listProducts.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> model = listProducts[index];
            List<String> itemIds = List<String>.from(model['itemIds'] ?? []);
            return FutureBuilder<Map<String, String>>(
              future: getInventoryNames(itemIds),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar nomes dos itens'));
                } else {
                  Map<String, String> inventoryNames = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Dismissible(
                        key: ValueKey<String>(model['id']),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: AppColors.sweepDeleteColor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 1.0),
                          child: const Icon(
                            Icons.delete_sweep,
                            color: AppColors.deleteIconColor,
                          ),
                        ),
                        onDismissed: (direction) {
                          remove(model);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 30,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              // print('Clicou');
                            },
                            onLongPress: () => ProductFormModal.showFormModal(context, bdFirebase, refresh, model: model),
                            leading: const Icon(Icons.fastfood),
                            title: Text(
                              model['name'],
                              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Itens: ${inventoryNames.values.join(', ')}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'R\$${model['price'].toString()}',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.buttonColor,)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ProductFormModal.showFormModal(context, bdFirebase, refresh),
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  refresh() async {
    List<Map<String, dynamic>> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await bdFirebase.collection('Produtos').get();
    for (var doc in snapshot.docs) {
      temp.add(doc.data());
    }
    setState(() {
      listProducts = temp;
    });
  }

  void remove(Map<String, dynamic> model) {
    bdFirebase.collection('Produtos').doc(model['id']).delete();
    refresh();
  }
}
