import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> enterUser(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      print('Logado com sucesso!!!!!!');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
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
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await userCredential.user!.updateDisplayName(name);
      print('Metodo de cadastrar de usuário');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Este e-mail já está em uso por outro usuário!';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> redefinePassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print('Esqueci a senha clicado!!!!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {
        return ('Informe um email');
      }
      return e.code;
    }
    return null;
  }

  Future<String?> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<Map<String, String?>> getUserInfo() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String? name = user.displayName;
      String? email = user.email;
      return {'name': name, 'email': email};
    } else {
      throw Exception("No user is currently logged in.");
    }
  }

  Future<String?> removeUser({required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _firebaseAuth.currentUser!.email!,
          password: password
      );
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}
