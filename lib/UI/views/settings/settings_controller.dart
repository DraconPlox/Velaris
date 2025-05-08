import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velaris/service/auth_service.dart';

import '../../../model/entity/dream_user.dart';
import '../../../service/firestore_service.dart';
import '../login/login_view.dart';

class SettingsController {
  FirestoreService firestoreService = FirestoreService();
  AuthService authService = AuthService();
  DreamUser? user;

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(FirebaseAuth.instance.currentUser!.uid);
  }
  
  Future<bool> hasProviderGoogle() async {
    return (await authService.getUserProviders()).contains("google.com");
  }

  Future<void> cerrarSesion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  DreamUser? getUser() {
    return user;
  }
}
