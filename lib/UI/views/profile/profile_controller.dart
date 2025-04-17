import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:velaris/service/firestore_service.dart';

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

  Future<String?> getDescription() async {
    return firestoreService.getDescription(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<String?> getGender() async {
    return firestoreService.getGender(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<DateTime?> getDob() async {
    return firestoreService.getDob(FirebaseAuth.instance.currentUser!.uid);
  }
}
