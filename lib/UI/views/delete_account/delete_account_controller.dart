import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountController {
  Future<bool> eliminarUsuario() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final uid = user.uid;

      // Eliminar el documento en Firestore
      await FirebaseFirestore.instance.collection('user').doc(uid).delete();

      // Eliminar el usuario de Firebase Auth
      await user.delete();

      return true;
    } catch (e) {
      return false;
    }
  }

}