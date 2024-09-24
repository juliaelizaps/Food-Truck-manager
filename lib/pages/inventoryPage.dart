import 'package:flutter/material.dart';
import 'addProduct.dart';
import '../models/inventory_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Inventory> inventories = [];

  @override
  void initState() {
    super.initState();
    fetchInventories();
  }

  Future<void> fetchInventories() async {
    // Add logic to fetch inventories from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque'),
      ),
      body: ListView.builder(
        itemCount: inventories.length,
        itemBuilder: (context, index) {
          final inventory = inventories[index];
          return ListTile(
            title: Text('Product ID: ${inventory.productId}'),
            subtitle: Text('Quantity: ${inventory.availableQuantity}'),
            trailing: Text('Last updated: ${inventory.lastUpdated}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        label: Text('Add Product'),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _addInventory(Inventory inventory) {
    setState(() {
      inventories.add(inventory);
    });
  }
}
