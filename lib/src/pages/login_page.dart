import 'package:flutter/material.dart';
import 'package:gf/src/shared/colors.dart';
import '../routes/app_routes.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  AppColors.initialPageBackground,
                  Colors.red.shade800,
                  Colors.red.shade400
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: const Duration(milliseconds: 1000), child: const Text("Login", style: TextStyle(color: AppColors.loginAppText, fontSize: 40),)),
                  const SizedBox(height: 10,),
                  FadeInUp(duration: const Duration(milliseconds: 1300), child: const Text("Gerencie", style: TextStyle(color:AppColors.loginAppText, fontSize: 18),)

                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60,),
                      FadeInUp(duration: const Duration(milliseconds: 1400), child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "Email ou Telefone",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                              ),
                              child: const TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Senha",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){}, //Adicionar aqui o caminho da lógica para recuperar a senha
                        child: FadeInUp(duration: const Duration(milliseconds: 1500),
                            child: const Text("Esqueceu a senha?", style: TextStyle(color: Colors.blueAccent),)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FadeInUp(duration: const Duration(milliseconds: 1600), child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(AppRouter.home);
                        },
                        height: 50,
                        //margin: EdgeInsets.symmetric(horizontal: 50),
                        color: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        // decoration: BoxDecoration(
                        // ),
                        child: const Center(
                          child: Text("Login", style: TextStyle(color: AppColors.appPageBackground, fontWeight: FontWeight.bold),),
                        ),
                      )),
                      const SizedBox(height: 20,),
                      FadeInUp(duration:const Duration(milliseconds: 1700),
                          child: const Text("Não possui conta?",
                            style: TextStyle(
                                color: Colors.grey),)),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){}, //Adicionar aqui o caminho da lógica para recuperar a senha
                        child: FadeInUp(duration: const Duration(milliseconds: 1800),
                            child: const Text("Criar conta", style: TextStyle(color: Colors.blueAccent),)
                        ),
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
