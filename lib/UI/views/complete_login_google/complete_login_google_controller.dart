import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream_user.dart';
import '../../../service/auth_service.dart';

class CompleteLoginGoogleController {
  final AuthService authService = AuthService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirestoreService firestoreService = FirestoreService();

  Future<bool> existeNickname(String nickname) async {
    List<DreamUser> users = await firestoreService.searchUsersByNickname(nickname);
    return users.isNotEmpty;
  }

  Future<bool> register(DreamUser user) async {
    try {
      await firestore.collection('user').doc(user.id).set(user.toJson());

      return true;
    } catch (e){
      return false;
    }
  }
}
