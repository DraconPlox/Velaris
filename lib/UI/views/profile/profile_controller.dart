import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
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
      if (dream.lucid == true) {
        lucidos++;
      } else {
        noLucidos++;
      }
    }

    return {
      'Lúcido': lucidos,
      'No lúcido': noLucidos,
    };
  }

  Future<bool> sendFriendRequest(String id) async {
    if (await firestoreService.createFriendRequest(id)) {
      await sendToTopicHttp(id);
      return true;
    }

    return false;
  }

  Future<bool> cancelFriendRequest(String id) async {
    return await firestoreService.deleteFriendRequest(id);
  }

  Future<bool> deleteFriend(String id) async {
    return await firestoreService.deleteFriend(id);
  }

  Future<bool> bloqUser(String? id) async {
    return await firestoreService.bloqUser(id);
  }

  Future<bool> desbloqUser(String id) async {
    return await firestoreService.desbloqUser(id);
  }

  Future<bool> getIfExistsPendingRequest(String id) async {
    return await firestoreService.getIfExistsPendingRequest(id);
  }

  Future<bool> getIfFriend(String id) async {
    return await firestoreService.getIfFriend(id);
  }

  Future<void> sendToTopicHttp(String id) async {
    final url = Uri.parse(
        'https://us-central1-velaris-5a288.cloudfunctions.net/sendToTopic'
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'topic': 'user_$id',
        'title': 'Has recibido una solicitud de amistad',
        'body': 'Ven a comprobarla',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('Enviado ok, messageId=${data['messageId']}');
    } else {
      print('Error HTTP ${response.statusCode}: ${response.body}');
    }
  }
}
