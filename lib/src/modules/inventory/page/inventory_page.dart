import 'package:flutter/material.dart';
import 'package:gf/src/modules/inventory/components/inventory_form_modal.dart';
import 'package:gf/src/modules/inventory/model/inventory_model.dart'; // Certifique-se de que este caminho está correto
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
          : ListView(
        children: List.generate(
          listInventory.length,
              (index) {
            Inventory model = listInventory[index];
            return ListTile(
              leading: const Icon(Icons.list_alt_rounded),
              title: Text(model.name),
              subtitle: Text('ID: ${model.id} - Quantidade: ${model.quantity}'), // Mostrando a quantidade também
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => InventoryFormModal.showFormModal(context, bdFirebase, refresh), // Usando a classe InventoryFormModal
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add),
      ),
    );
  }
  refresh() async{
    List<Inventory> temp =[];

    QuerySnapshot<Map<String, dynamic>> snapshot =
    await bdFirebase.collection('Estoque').get();
    for (var doc in snapshot.docs){
     temp.add(Inventory.fromMap(doc.data()));
    }
    setState((){
      listInventory = temp;
    });
  }
}

