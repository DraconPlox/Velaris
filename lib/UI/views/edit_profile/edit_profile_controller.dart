import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileController {
  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void updateImage(String uid, File imageFile) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child('$uid.png');

    try {
      await ref.putFile(imageFile);
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }


}