import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gf/src/modules/dashboard/page/dashboard_page.dart';
import 'package:gf/src/modules/login/page/login_page.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState== ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator());
        }else{
          if(snapshot.hasData){
            return const DashboardPage();
          }else {
            return const LoginPage();
          }
        }
      },
    );
  }
}


