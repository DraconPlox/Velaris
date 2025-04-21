import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/entity/dream_user.dart';
import '../../../service/auth_service.dart';

class RegisterController {
  final AuthService authService = AuthService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> register(
    String email,
    String password,
    String nickname,
    String gender,
    DateTime dob,
  ) async {
    try {
      // Registrar el usuario
      UserCredential? userCredential = await authService.registerWithEmail(
        email,
        password,
      );

      String? uid = userCredential?.user?.uid;
      if (uid == null)
        throw Exception("No se pudo obtener el UID del usuario.");

      // Crear modelo DreamUser
      DreamUser newUser = DreamUser(
        id: uid,
        nickname: nickname,
        gender: gender,
        email: email,
        dob: dob,
        description: 'Esto es una descripción.',
        friends: [],
      );

      // Guardar en Firestore
      await firestore.collection('user').doc(uid).set(newUser.toJson());
      await FirebaseAuth.instance.signOut();

      print("Usuario creado y guardado en Firestore.");
      return true;
    } catch (e) {
      print("Error en el registro: $e");
      return false;
    }
  }
}
