import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:velaris/model/entity/dream_user.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class ProfileController {
  FirestoreService firestoreService = FirestoreService();
  static String? url;
  static String? userId;
  DreamUser? user;

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(FirebaseAuth.instance.currentUser!.uid);
  }

  DreamUser? getUser() {
    return user;
  }

  // Método para obtener la URL de la imagen de perfil del usuario actual
  Future<String?> getProfilePictureUrl() async {
    if (userId == null) {
      userId = FirebaseAuth.instance.currentUser?.uid;
    }
    if (userId != null && userId != FirebaseAuth.instance.currentUser?.uid) {
      userId = FirebaseAuth.instance.currentUser?.uid;
      url = null;
    }
    if (url == null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return null;

        final String uid = user.uid;

        // Ruta a la imagen en Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/$uid.png');

        final urlPicture = await ref.getDownloadURL();
        url = urlPicture;
        return url;
      } catch (e) {
        print('Error obteniendo imagen de perfil: $e');
        return null;
      }
    } else {
      return url;
    }
  }

  String? getNickname() {
    return user?.nickname;
  }

  String? getDescription() {
    return user?.description;
  }

  String? getGender() {
    return user?.gender;
  }

  DateTime? getDob() {
    return user?.dob;
  }

  Future<List<Dream>> getDreams({String? userId}) {
    return firestoreService.getDreams(userId??FirebaseAuth.instance.currentUser!.uid);
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

  sendFriendRequest(String id) async {
    return await firestoreService.createFriendRequest(id);
  }

  Future<bool>cancelFriendRequest(String id) async {
    return await firestoreService.deleteFriendRequest(id);
  }

  Future<bool> deleteFriend(String id) async {
    return await firestoreService.deleteFriend(id);
  }

  Future<bool> getIfExistsPendingRequest(String id) async {
    return await firestoreService.getIfExistsPendingRequest(id);
  }

  Future<bool> getIfFriend(String id) async {
    return await firestoreService.getIfFriend(id);
  }
}
