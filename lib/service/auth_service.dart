import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velaris/UI/views/complete_login_google/complete_login_google_view.dart';
import 'package:velaris/UI/views/login/login_view.dart';

import '../UI/views/calendar_dreams/calendar_dreams_view.dart';
import '../UI/views/delete_confirm_login/delete_confirm_login_view.dart';
import '../model/entity/dream_user.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserProviders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return [];

    return user.providerData.map((provider) => provider.providerId).toList();
  }

  /// Registro con email y contraseña
  Future<UserCredential?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print("¡Usuario creado con éxito!");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuth error: ${e.code} - ${e.message}");
    }
  }

  /// Login con email y contraseña
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Error en login con email: ${e.code} - ${e.message}');
      return null;
    }
  }

  /// Login con cuenta de Google
  Future<User?> loginWithGoogle() async {
    try {
      await logout();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Error en login con Google: ${e.code} - ${e.message}');
      return null;
    }
  }

  Future<String> eliminarUsuario(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return "";

    final providers = await getUserProviders();

    if (providers.contains('google.com')) {
      try {
        // Reautenticacion con Google
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return "";

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await user.reauthenticateWithCredential(credential);

        // Eliminar cuenta
        await user.delete();
        print('Cuenta eliminada exitosamente');

        return user.uid;

      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              'Error al eliminar al usuario.',
            ),
          ),
        );
      }
    } else {
      // Redirigir a la pantalla DeleteConfirmLogin
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DeleteConfirmLoginView()),
      );
    }

    return "";
  }

  void listenAuthChanges(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print("Usuario ha cerrado sesión o no ha iniciado sesión.");
      } else {
        DreamUser? dreamUser = await firestoreService.getDreamUser(user.uid);
        print("Usuario ha iniciado sesión: ${user.email}");
        if (dreamUser == null) {
           dreamUser = DreamUser(
              id: user.uid,
              nickname: user.displayName,
              gender: null,
              email: user.email,
              dob: null,
              description: 'Esto es una descripción.',
              friends: [],
              profilePicture: user.photoURL,
              search_nickname: user.displayName?.toLowerCase()
          );
        }

        if (dreamUser.gender == null || dreamUser.dob == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CompleteLoginGoogleView(user: dreamUser!)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CalendarDreamsView()),
          );
        }
      }
    });
  }

  /// Cierra sesión
  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// Usuario actual
  User? get currentUser => _auth.currentUser;
}