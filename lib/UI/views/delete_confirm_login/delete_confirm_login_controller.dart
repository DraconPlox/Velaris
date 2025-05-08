import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

class DeleteConfirmLoginController {
  FirestoreService firestoreService = FirestoreService();

  Future<bool> deleteAccount(String email, String password) async {
    try {
      // Autenticar al usuario
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = authResult.user;
      if (user == null) return false;

      final uid = user.uid;

      await firestoreService.deleteUser(uid);

      // Eliminar el usuario de Firebase Auth
      await user.delete();

      return true;
    } catch (e) {
      return false;
    }
  }
}
