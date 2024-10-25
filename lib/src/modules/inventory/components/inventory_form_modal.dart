import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:gf/src/shared/components/red_button.dart';
import 'package:gf/src/modules/inventory/model/inventory_model.dart';

class InventoryFormModal {
  static void showFormModal(BuildContext context, FirebaseFirestore bdFirebase, VoidCallback refresh, {Inventory? model}) {
    String labelTitle = "Adicionar Item";
    String labelConfirmationButton = "Adicionar";
    String labelSkipButton = "Cancelar";
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    if (model != null) {
      labelTitle = "Editar: ${model.name}";
      nameController.text = model.name;
      quantityController.text = model.quantity.toString(); // Preenchendo a quantidade
      labelConfirmationButton = "Salvar Alterações";
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              Text(labelTitle, style: Theme.of(context).textTheme.headline5),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nome do Item"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Quantidade"),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(labelSkipButton),
                  ),
                  const SizedBox(width: 16),
                  RedButton(
                    text: labelConfirmationButton,
                    onPressed: () async {
                      try {
                        Inventory inventory = Inventory(
                          id: model?.id ?? const Uuid().v1(),
                          name: nameController.text,
                          quantity: int.parse(quantityController.text), // Convertendo para int
                          lastUpdated: DateTime.now(),
                        );
                        await bdFirebase
                            .collection("Estoque")
                            .doc(inventory.id)
                            .set(inventory.toMap());
                        Navigator.pop(context);
                        refresh();
                      } catch (e) {
                        print("Erro ao salvar no Firestore: $e");
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

