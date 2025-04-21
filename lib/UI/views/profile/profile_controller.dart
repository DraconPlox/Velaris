import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class ProfileController {
  FirestoreService firestoreService = FirestoreService();

  // Método para obtener la URL de la imagen de perfil del usuario actual
  Future<String?> getProfilePictureUrl() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final String uid = user.uid;

      // Ruta a la imagen en Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/$uid.png');

      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error obteniendo imagen de perfil: $e');
      return null;
    }
  }

  Future<String?> getNickname() async {
    return firestoreService.getNickname(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<String?> getDescription() async {
    return firestoreService.getDescription(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<String?> getGender() async {
    return firestoreService.getGender(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<DateTime?> getDob() async {
    return firestoreService.getDob(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }

  Map<String, int> getSuenosLucidos(List<Dream> dreams) {
    int lucidos = 0;
    int noLucidos = 0;

    for (var dream in dreams) {
      if (dream.lucido == true) {
        lucidos++;
      } else {
        noLucidos++;
      }
    }

    return {
      'Lucido': lucidos,
      'No lucido': noLucidos,
    };
  }
}
