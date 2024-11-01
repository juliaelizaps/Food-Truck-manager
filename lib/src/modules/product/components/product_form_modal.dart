// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:gf/src/shared/components/red_button.dart';
import 'package:gf/src/modules/inventory/model/inventory_model.dart';

class ProductFormModal {
  static void showFormModal(BuildContext context, FirebaseFirestore bdFirebase, VoidCallback refresh, {Map<String, dynamic>? model}) {
    String labelTitle = "Adicionar Produto";
    String labelConfirmationButton = "Adicionar";
    String labelSkipButton = "Cancelar";
    TextEditingController nameController = TextEditingController();
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> selectedItems = []; // Lista de IDs dos itens selecionados

    if (model != null) {
      labelTitle = "Editar: ${model['name']}";
      nameController.text = model['name'];
      selectedItems = List<String>.from(model['itemIds']);
      labelConfirmationButton = "Salvar Alterações";
    }

    Future<void> fetchInventoryItems() async {
      QuerySnapshot<Map<String, dynamic>> snapshot = await bdFirebase.collection('Estoque').get();
      dropdownItems = snapshot.docs.map((doc) {
        Inventory item = Inventory.fromMap(doc.data());
        return DropdownMenuItem<String>(
          value: item.id,
          child: Text(item.name),
        );
      }).toList();
    }

    fetchInventoryItems().then((_) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text(labelTitle, style: Theme.of(context).textTheme.headline5),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Nome do Produto"),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Selecionar Item do Estoque"),
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        if (newValue != null && !selectedItems.contains(newValue)) {
                          setState(() {
                            selectedItems.add(newValue);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    if (selectedItems.isNotEmpty)
                      Wrap(
                        children: selectedItems.map((id) {
                          var itemName = dropdownItems.firstWhere((item) => item.value == id).child;
                          return Chip(
                            label: Text((itemName as Text).data!),
                            onDeleted: () {
                              setState(() {
                                selectedItems.remove(id);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(labelSkipButton),
                        ),
                        const SizedBox(width: 16),
                        RedButton(
                          text: labelConfirmationButton,
                          onPressed: () async {
                            try {
                              String productId = model?['id'] ?? const Uuid().v1();

                              // Verifica se algum item foi selecionado
                              if (selectedItems.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Selecione pelo menos um item do estoque")),
                                );
                                return;
                              }

                              // Salva o produto
                              var newProduct = {
                                'id': productId,
                                'name': nameController.text,
                                'itemIds': selectedItems,
                                'lastUpdated': DateTime.now(),
                              };
                              await bdFirebase.collection("Produtos").doc(productId).set(newProduct);
                              if (Navigator.canPop(context)) {
                               Navigator.pop(context);
                               }
                              refresh();
                            } catch (e) {
                              //print("Erro ao salvar no Firestore: $e");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    });
  }
}
