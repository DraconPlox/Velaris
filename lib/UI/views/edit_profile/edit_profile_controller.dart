import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:velaris/model/entity/dream_user.dart';
import 'package:velaris/service/firestore_service.dart';

class EditProfileController {
  FirestoreService firestoreService = FirestoreService();
  DreamUser? user;

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(FirebaseAuth.instance.currentUser?.uid??"");
  }

  DreamUser? getDreamUser() {
    return user;
  }

  Future<String?> updateImage(String uid, File imageFile) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child('$uid.png');

    try {
      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null;
    }
  }

  Future<bool> updateUser({File? pickedImage, String? nickname, String? description, DateTime? selectedDate, String? gender}) async {
    if (user == null) return false;

    String? url;

    if (pickedImage != null) {
      url = await updateImage(user!.id??"", pickedImage);
    }

    try {
      await FirebaseFirestore.instance.collection('user').doc(user!.id).update(
        user!.copyWith(
          nickname: nickname,
          search_nickname: nickname?.toLowerCase(),
          description: description,
          dob: selectedDate,
          gender: gender,
          profilePicture: url,
        ).toJson()
      );

      return true;
    } catch (e) {
      return false;
    }
  }


}