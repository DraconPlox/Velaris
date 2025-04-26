import '../../../model/entity/dream_user.dart';
import '../../../service/firestore_service.dart';

class SearchUserController {
  FirestoreService firestoreService = FirestoreService();

  Future<List<DreamUser>> searchUsers(String query) async {
    if (query.isEmpty) {
      return [];
    }

    return await firestoreService.searchUsersByNickname(query);
  }
}