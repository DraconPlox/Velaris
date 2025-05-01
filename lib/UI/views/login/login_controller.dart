import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/service/auth_service.dart';

class LoginController {
  AuthService authService = AuthService();

  Future<User?> login(String email, String password) {
    return authService.loginWithEmail(email, password);
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
