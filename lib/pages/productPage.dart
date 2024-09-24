import 'package:flutter/material.dart';
import 'package:gf/pages/addProduct.dart';
import '../ widgets/custom_widgets.dart';
import '../models/product_model.dart';
import 'inventoryPage.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              spacing: 12.0,
              alignment: WrapAlignment.center,
              children: [
                MyFilterChip(label: 'Todos', isSelected: true,),
                MyFilterChip(label: 'Lanches'),
                MyFilterChip(label: 'Bebidas'),
                MyFilterChip(label: 'Porções'),
                MyFilterChip(label: 'Pasteis'),
                MyFilterChip(label: 'Molhos'),
                MyFilterChip(label: 'Adicionais'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
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
}
