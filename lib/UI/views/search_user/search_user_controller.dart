import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/entity/dream_user.dart';
import '../../../service/firestore_service.dart';

class SearchUserController {
  FirestoreService firestoreService = FirestoreService();
  DreamUser? user;

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(FirebaseAuth.instance.currentUser!.uid);
  }

  DreamUser? getUser() {
    return user;
  }

  Future<List<DreamUser>> searchUsers(String query) async {
    if (query.isEmpty) {
      return [];
    }

    return await firestoreService.searchUsersByNickname(query);
  }
}