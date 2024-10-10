import 'package:flutter/material.dart';

import '../ widgets/sideBar.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  double price = 0.0;
  String image = '';
  String category = 'Lanches';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      drawer:const SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) {
                  name = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) {
                  description = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  price = double.tryParse(value ?? '0') ?? 0.0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Imagem-URL'),
                onSaved: (value) {
                  image = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                value: category,
                items: ['Lanches', 'Bebidas', 'Porções','Pastéis', 'Molhos','Adicionais']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    category = value ?? 'Lanches';
                  });
                },
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Aqui você pode adicionar a lógica para salvar o produto no banco de dados
                    print('Product added: $name, $description, $price, $image, $category');
                  }
                },
                child: Text('Salvar produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
