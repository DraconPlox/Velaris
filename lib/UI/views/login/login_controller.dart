import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/service/auth_service.dart';

class LoginController {
  AuthService authService = AuthService();

  Future<User?> login(String email, String password) {
    return authService.loginWithEmail(email, password);
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("COSO1: GoogleSignIn().signIn()");
      if (googleUser == null) {
        print("CANCEL");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("COSO2: googleUser.authentication");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print("COSO3: FirebaseAuth.instance.signInWithCredential(credential)");
      // Usuario autenticado correctamente
      final user = userCredential.user;
      print("Usuario autenticado: ${user?.displayName}");

      // Aqui puedes navegar o guardar datos si hace falta

    } catch (e) {
      print("Error al iniciar sesion con Google: $e");
      // Muestra un mensaje al usuario si quieres
    }
  }


  void listenAuthChanges(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Usuario ha cerrado sesión o no ha iniciado sesión.");
      } else {
        print("Usuario ha iniciado sesión: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarDreamsView()),
        );
      }
    });
  }
}
