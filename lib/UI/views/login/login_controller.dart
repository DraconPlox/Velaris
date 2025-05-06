import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/service/auth_service.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream_user.dart';

class LoginController {
  final AuthService authService = AuthService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirestoreService firestoreService = FirestoreService();

  Future<User?> login(String email, String password) {
    return authService.loginWithEmail(email, password);
  }

  Future<void> loginWithGoogle() async {
    await authService.loginWithGoogle();
  }

  void listenAuthChanges(BuildContext context) {
    authService.listenAuthChanges(context);
  }
}
