import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/model/entity/dream.dart';
import 'package:velaris/model/entity/friend_request.dart';

import '../../../model/entity/dream_user.dart';
import '../../../service/firestore_service.dart';

class ViewFriendsController {
  FirestoreService firestoreService = FirestoreService();
  DreamUser? user;

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(FirebaseAuth.instance.currentUser!.uid);
  }

  DreamUser? getUser() {
    return user;
  }

  Future<List<DreamUser>> getFriends(List<String> listaIds) async {
    return await firestoreService.getDreamUserFriends(listaIds);
  }

  Future<List<DreamUser>> getRequestsReceive() async {
    List<FriendRequest> listaRequests = await firestoreService.getFriendRequestReceiver(FirebaseAuth.instance.currentUser!.uid);

    List<DreamUser> listaUsers = [];
    for (int i = 0; i < listaRequests.length; i++) {
      DreamUser? user = await firestoreService.getDreamUser(listaRequests[i].senderId ?? "");
      if (user != null) listaUsers.add(user);
    }

    return listaUsers;
  }

  Future<List<DreamUser>> getRequestsSender() async {
    List<FriendRequest> listaRequests = await firestoreService.getFriendRequestSender(FirebaseAuth.instance.currentUser!.uid);

    List<DreamUser> listaUsers = [];
    for (int i = 0; i < listaRequests.length; i++) {
      DreamUser? user = await firestoreService.getDreamUser(listaRequests[i].receiverId ?? "");
      if (user != null) listaUsers.add(user);
    }

    return listaUsers;
  }

  Future<List<DreamUser>> getUsersBlocked(List<String> listaIds) async {
    return await firestoreService.getDreamUserBlocked(listaIds);
  }

  Future<bool> acceptRequest(String id) async {
    return await firestoreService.acceptFriendRequest(id);
  }

  Future<void> declineRequest(String id) async {
    await firestoreService.deleteFriendRequest(id);
  }

  Future<bool> desbloqUser(String id) async {
    return await firestoreService.desbloqUser(id);
  }
}