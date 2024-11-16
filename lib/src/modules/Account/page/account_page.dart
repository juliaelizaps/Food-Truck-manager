import 'package:flutter/material.dart';
import 'package:gf/src/modules/Account/componets/confirm_delete_dialog.dart';
import 'package:gf/src/modules/login/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'package:gf/src/shared/components/sideBar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future<Map<String, String?>> _userInfo;

  @override
  void initState() {
    super.initState();
    _userInfo = AuthService().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Informações do Usuário'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _userInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final userInfo = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.buttonColor,
                      radius: 50,
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 50,
                        color: AppColors.userIcon,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userInfo['name'] ?? 'Nome não disponível',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userInfo['email'] ?? 'Email não disponível',
                      style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        showDeleteConfirmationDialog(context: context, email: '');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.buttonColor,
                      ),
                      child: const Text('Excluir Conta'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Nenhum usuário logado.'),
            );
          }
        },
      ),
    );
  }
}
