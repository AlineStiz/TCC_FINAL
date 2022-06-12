import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  void _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  void _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future registrar(String email, String senha) async {
    isLoading = true;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido. Tente novamente');
      } else {
        throw AuthException(e.code);
      }
    }
    isLoading = false;
  }

  Future<void> login(String email, String senha) async {
    isLoading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido. Tente novamente');
      } else if (e.code == 'too-many-requests') {
        throw AuthException('Muitas solicitações. Tente novamente mais tarde');
      } else {
        throw AuthException(e.code);
      }
    }
    isLoading = false;
  }

  Future forgotPassword(String email) async {
    isLoading = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      throw AuthException(e.code);
    }
    isLoading = false;
  }

  Future logout() async {
    await _auth.signOut();
    _getUser();
  }
}
