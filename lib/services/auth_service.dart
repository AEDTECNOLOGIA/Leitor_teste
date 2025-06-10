import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream para monitorar mudanças no estado de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Login com email e senha
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Erro ao fazer login: ${e.toString()}');
    }
  }

  // Login com Google
  Future<void> signInWithGoogle() async {
    try {
      // Inicia o processo de login com Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      // Obtém a autenticação do Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Cria um credencial do Firebase com as informações do Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Faz login com o Firebase usando a credencial do Google
      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Erro ao fazer login com Google: ${e.toString()}');
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: ${e.toString()}');
    }
  }

  // Verifica se o usuário está logado
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  // Obtém o email do usuário atual
  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  // Obtém o nome do usuário atual
  String? getCurrentUserName() {
    return _auth.currentUser?.displayName;
  }

  // Obtém a foto do usuário atual
  String? getCurrentUserPhotoUrl() {
    return _auth.currentUser?.photoURL;
  }
}
