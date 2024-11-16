import 'package:flutter/material.dart';
import 'package:gf/src/shared/components/sideBar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [],
      ),
      drawer:const SideBar(),
      body: const SizedBox(
        child: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}





