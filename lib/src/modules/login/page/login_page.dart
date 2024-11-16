import 'package:flutter/material.dart';
import 'package:gf/src/modules/login/component/show_snackbar.dart';
import 'package:gf/src/modules/login/services/auth_service.dart';
import 'package:gf/src/shared/colors/colors.dart';
import 'package:animate_do/animate_do.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/components/red_button.dart';
import '../controller/password_visibility_controller.dart';
import '../routes/auth_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isEntrando = true;
  AuthService authService = AuthService();

  // Simular criação de usuário (entra para teste somente)
  // void _simularCriarUsuario(
  //     {required String email, required String senha, required String nome}) {
  //   print("Usuário criado: Email: $email, Senha: $senha, Nome: $nome");
  //   Navigator.of(context).pushReplacementNamed(AppRouter.home);
  // }

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
              Colors.red.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    ),
                  ),
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
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
                                      offset: Offset(0, 10)),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "O valor de e-mail deve ser preenchido";
                                        }
                                        if (!value.contains("@") ||
                                            !value.contains(".") ||
                                            value.length < 4) {
                                          return "O valor do e-mail deve ser válido";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: PasswordVisibilityController(
                                      builder: (obscureText, toggleVisibility) {
                                        return TextFormField(
                                          controller: _senhaController,
                                          obscureText: obscureText,
                                          decoration: InputDecoration(
                                            hintText: "Senha",
                                            hintStyle:const TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: toggleVisibility,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Insira uma senha válida.";
                                            }
                                            if (value.length < 4) {
                                              return "Insira uma senha válida.";
                                            }
                                            return null;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isEntrando,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: _confirmaController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              hintText: "Confirme a senha",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Confirme a senha";
                                              }
                                              if (value !=
                                                  _senhaController.text) {
                                                return "As senhas devem ser iguais.";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: _nomeController,
                                            decoration: const InputDecoration(
                                              hintText: "Nome",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Insira um nome.";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: isEntrando,
                            child: GestureDetector(
                              onTap: () {
                                forgotPasswordClicked();
                                //print('Esqueci a senha clicado!!!!');
                              },
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 1500),
                                child: const Text(
                                  "Esqueceu a senha?",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: RedButton(
                              text: isEntrando ? "Login" : "Cadastrar",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (isEntrando) {
                                    _enterUser(
                                      email: _emailController.text,
                                      senha: _senhaController.text,
                                    );
                                  } else {
                                    _createUser(
                                      email: _emailController.text,
                                      senha: _senhaController.text,
                                      nome: _nomeController.text,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1700),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEntrando = !isEntrando;
                                });
                                _formKey.currentState?.reset();
                              },
                              child: Text(
                                isEntrando
                                    ? "Não possui conta? Criar conta"
                                    : "Já possui conta? Login",
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _enterUser({required String email, required String senha}) {
    authService.enterUser(
        email: email, senha: senha).then((String? error) => {
      if(error ==null){
        showSnackBar(context: context, message: 'Usuário logado com sucesso', isError: false),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AuthRouter()))
      } else{
        showSnackBar(context: context, message: error)
      }
    }
    );
  }

  void _createUser({required String email, required String senha, required String nome}) {
    authService.createUser(
        email: email, senha: senha, nome:nome).then((String? error) => {
    if (error==null){
        showSnackBar(context: context, message: 'Conta criada com sucesso!', isError: false),
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthRouter()))
    }else{
    showSnackBar(context: context, message: error)
    }
    });

  }

  forgotPasswordClicked(){
    String email= _emailController.text;
    showDialog(
        context: context,
        builder:(context){
          TextEditingController redefiningPasswordController =
          TextEditingController(text: email);
          return AlertDialog(
            title: const Text('Confirmar o email para redefinir senha'),
            content: TextFormField (controller: redefiningPasswordController,decoration: const InputDecoration(label: Text('Confime o email')),
            ),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: [
              RedButton(
                text: 'Redefinir senha',
                onPressed: (){
                  authService.redefinePassword(email: redefiningPasswordController.text).then((String? error) {
                    if(error == null){
                      showSnackBar(context: context, message: 'Email de redefinição de senha enviado.', isError: false,
                      );
                    } else{
                      showSnackBar(context: context, message: error);
                    }
                    Navigator.pop(context);
                  });
                },
              ),
            ],
      );
    });
  }
}
