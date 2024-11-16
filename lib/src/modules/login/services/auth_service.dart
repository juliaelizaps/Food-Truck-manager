import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> enterUser({required String email,required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      print('Logado com sucesso!!!!!!');
    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case "INVALID_LOGIN_CREDENTIALS":
          return "Usuário ou senha incorretos, tente novamente";
        //case "wrong-password":
          return "Senha incorreta!";
      }
      return e.code;
    }
    return null;
  }
  Future<String?> createUser({
    required String email,
    required String senha, 
    required String nome,
  }) async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: senha
      );
      
      await userCredential.user!.updateDisplayName(nome) ;
      print('Metodo de cadastrar de usuário');

    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case 'email-already-in-use':
        return 'Este e-mail já está em uso por outro usuário!';
      }
      return e.code;
    }
    return null;
}
  Future<String?> redefinePassword({required String email}) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print('Esqueci a senha clicado!!!!');
    }on FirebaseAuthException catch(e){
      if(e.code == 'unknown'){
        return('Informe um email');
      }
      return e.code;
    }
    return null;
  }
}