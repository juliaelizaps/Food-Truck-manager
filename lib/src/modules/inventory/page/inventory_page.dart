import 'package:flutter/material.dart';
import 'package:gf/src/modules/inventory/components/inventory_form_modal.dart';
import 'package:gf/src/modules/inventory/model/inventory_model.dart';
import 'package:gf/src/shared/colors/colors.dart';
import '../../../shared/components/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Inventory> listInventory = [];
  FirebaseFirestore bdFirebase = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
      ),
      drawer: const SideBar(),
      body: (listInventory.isEmpty)
          ? const Center(
        child: Text(
          'Você ainda não cadastrou produtos ao estoque!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      )
          : RefreshIndicator(
        onRefresh: () {
          return refresh();
        },
        child: ListView.builder(
          itemCount: listInventory.length,
          itemBuilder: (context, index) {
            Inventory model = listInventory[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              child: ClipRRect(

                borderRadius: BorderRadius.circular(5.0),
                  child: Dismissible(
                  key: ValueKey<Inventory>(model),
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
                          offset: Offset(1, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        // print('Clicou');
                      },
                      onLongPress: () => InventoryFormModal.showFormModal(context, bdFirebase, refresh, model: model),
                      leading: const Icon(Icons.inventory_outlined),
                      title: Text(
                        model.name,
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), // Ajustando o tamanho da fonte do nome
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantidade: ${model.quantity}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ID: ${model.id} ',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => InventoryFormModal.showFormModal(context, bdFirebase, refresh),
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  refresh() async {
    List<Inventory> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await bdFirebase.collection('Estoque').get();
    for (var doc in snapshot.docs) {
      temp.add(Inventory.fromMap(doc.data()));
    }
    setState(() {
      listInventory = temp;
    });
  }

  void remove(Inventory model) {
    bdFirebase.collection('Estoque').doc(model.id).delete();
    refresh();
  }
}
