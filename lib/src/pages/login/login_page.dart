import 'package:flutter/material.dart';
import 'package:gf/src/pages/login/password_visibility_controller.dart';
import 'package:gf/src/shared/colors/colors.dart';
import '../../routes/app_routes.dart';
import 'package:animate_do/animate_do.dart';

import '../../shared/components/red_buttom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          AppColors.initialPageBackground,
          Colors.red.shade800,
          Colors.red.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///sizedBox do Login e Senha
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.loginAppText, fontSize: 40),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "GERENCIE",
                        style: TextStyle(
                            color: AppColors.loginAppText,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ///Container branco curvado
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 40.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Insira seus dados",
                              style: TextStyle(
                                color: AppColors.appTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          14, 8, 3, 0.30196078431372547),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),

                            ///Login
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),

                                ///Senha
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: PasswordVisibilityController(
                                    builder: (obscureText, toggleVisibility) {
                                      return TextField(
                                        obscureText: obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Senha",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                                            onPressed: toggleVisibility,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///Texto azul executável "Esqueceu a senha?"
                      GestureDetector(
                        onTap: () {
                          //Adicionar aqui o caminho para página recuperar a senha
                        },
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1500),
                            child: const Text(
                              "Esqueceu a senha?",
                              style: TextStyle(color: Colors.blueAccent),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///Botão vermelho do Login: caracteristicas e funcionalidades
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: RedButton(
                          text: "Login",
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRouter.home);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: const Text(
                            "Não possui conta?",
                            style: TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(
                        height: 10,
                      ),

                      ///Texto azul executável Criar conta
                      GestureDetector(
                        onTap: () {
                          //Adicionar aqui o caminho para página recuperar a senha
                        },
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1800),
                            child: const Text(
                              "Criar conta",
                              style: TextStyle(color: Colors.blueAccent),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
