import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendario_sue%C3%B1os/calendar_dreams_view.dart';
import 'package:velaris/service/auth_service.dart';

class LoginController {
  AuthService authService = AuthService();

  login(String email, String password) {
    authService.loginWithEmail(email, password);
  }

  void listenAuthChanges(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Usuario ha cerrado sesión o no ha iniciado sesión.");
        // Aquí puedes navegar a login o hacer otra lógica
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
