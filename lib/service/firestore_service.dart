import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/model/entity/friend_request.dart';

import '../model/entity/dream.dart';
import '../model/entity/dream_user.dart';

class FirestoreService {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  Future<DreamUser?> getDreamUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        if (data != null) {
          return DreamUser.fromJson(data);
        } else {
          return null;
        }
      } else {
        print('Usuario no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener la descripción: $e');
      return null;
    }
  }

  Future<List<DreamUser>> getDreamUserFriends(List<String> listaIds) async {
    final usersSnapshot = await _getUserCollection()
        .where('id', whereIn: listaIds)
        .get();

    return usersSnapshot.docs.map((doc) => DreamUser.fromJson(doc.data())).toList();
  }

  Future<List<DreamUser>> getDreamUserBlocked(List<String> listaIds) async {
    final usersSnapshot = await _getUserCollection()
        .where('id', whereIn: listaIds)
        .get();

    return usersSnapshot.docs.map((doc) => DreamUser.fromJson(doc.data())).toList();
  }

  Future<String> createDream(Dream dream, String userId) async {
    var reference = _getDreamCollection(userId).doc();
    var id = reference.id;
    var saved = dream.copyWith(id: id);

    await _getDreamCollection(userId).doc(id).set(saved.toJson());

    return id;
  }

  Future<void> updateDream(Dream dream, String userId) async {
    if (dream.id == null) {
      throw Exception('El sueño debe tener un ID para poder actualizarlo.');
    }

    await _getDreamCollection(userId)
        .doc(dream.id)
        .update(dream.toJson());
  }

  Future<void> updateDreamUser(DreamUser dreamUser) async {
    await _getUserCollection()
        .doc(dreamUser.id)
        .update(dreamUser.toJson());
  }

  Future<Dream?> getDream(String userId, String dreamId) async {
    var doc = await _getDreamCollection(userId).doc(dreamId).get();

    if (doc.exists) {
      return Dream.fromJson(doc.data()!);
    } else {
      return null;
    }
  }

  Future<List<Dream>> getDreams(String userId) async {
    var querySnapshot = await _getDreamCollection(userId)
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Dream.fromJson(doc.data()))
        .toList();
  }

  Future deleteDream(String userId, String dreamId) async {
    await _getDreamCollection(userId).doc(dreamId).delete();
  }

  CollectionReference<Map<String, dynamic>> _getDreamCollection(String userId) {
    return _ref.collection("user").doc(userId).collection("dream");
  }

  Future<void> deleteDreamCollection(String userId) async {
    try {
      // Obtener la colección de sueños del usuario
      var dreamCollection = _getDreamCollection(userId);

      // Obtener todos los documentos de la colección
      var snapshot = await dreamCollection.get();

      // Eliminar cada documento
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('Todos los sueños han sido eliminados con éxito.');
    } catch (e) {
      print('Error al eliminar los sueños: $e');
    }
  }

  CollectionReference<Map<String, dynamic>> _getUserCollection() {
    return _ref.collection("user");
  }

  CollectionReference<Map<String, dynamic>> _getFriendRequestCollection() {
    return _ref.collection("friendRequest");
  }

  Future<List<DreamUser>> searchUsersByNickname(String query) async {
    String lowerQuery = query.toLowerCase();

    QuerySnapshot<Map<String, dynamic>> snapshot = await _getUserCollection()
        .where('search_nickname', isGreaterThanOrEqualTo: lowerQuery)
        .where('search_nickname', isLessThanOrEqualTo: lowerQuery + '\uf8ff')
        .get();

    return snapshot.docs.map((doc) => DreamUser.fromJson(doc.data())).toList();
  }

  Stream<List<Dream>> listenToDreams() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _getDreamCollection(uid)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Dream.fromJson(doc.data())).toList());
  }

  Future<List<FriendRequest>> getFriendRequestReceiver(String userId) async {
    final usersSnapshot = await _getFriendRequestCollection()
        .where('receiverId', isEqualTo: userId)
        .get();

    return usersSnapshot.docs.map((doc) => FriendRequest.fromJson(doc.data())).toList();
  }

  Future<List<FriendRequest>> getFriendRequestSender(String userId) async {
    final usersSnapshot = await _getFriendRequestCollection()
        .where('senderId', isEqualTo: userId)
        .get();

    return usersSnapshot.docs.map((doc) => FriendRequest.fromJson(doc.data())).toList();
  }

  Future<bool> createFriendRequest(String? receiveId) async {
    try {
      final docRef = _getFriendRequestCollection().doc();

      final friendRequest = FriendRequest(
        id: docRef.id,
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiveId,
      );

      await docRef.set(friendRequest.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getIfExistsPendingRequest(String receiveId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _getFriendRequestCollection()
        .where('senderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('receiverId', isEqualTo: receiveId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      querySnapshot = await _getFriendRequestCollection()
          .where('senderId', isEqualTo: receiveId)
          .where('receiverId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
    }

    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> getIfFriend(String id) async {
    DreamUser? user = await getDreamUser(id);
    List<String> listaAmigos = user?.friends??[];

    return listaAmigos.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<bool> deleteFriendRequest(String id) async {
    var querySnapshot = await _getFriendRequestCollection()
        .where('senderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('receiverId', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.delete();
      return true;
    } else {
      querySnapshot = await _getFriendRequestCollection()
          .where('senderId', isEqualTo: id)
          .where('receiverId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> acceptFriendRequest(String id) async {
    try {
      await deleteFriendRequest(id);

      DreamUser? dreamUser = await getDreamUser(id);
      DreamUser? me = await getDreamUser(FirebaseAuth.instance.currentUser!.uid);

      if (dreamUser == null || me == null) return false;

      List<String> listaFriendsDreamUser = dreamUser.friends??[];
      List<String> listaFriendsMe = me.friends??[];

      if (!listaFriendsDreamUser.contains(FirebaseAuth.instance.currentUser!.uid)) listaFriendsDreamUser.add(FirebaseAuth.instance.currentUser!.uid);
      if (!listaFriendsMe.contains(dreamUser.id??"")) listaFriendsMe.add(dreamUser.id??"");

      await updateDreamUser(dreamUser.copyWith(friends: listaFriendsDreamUser));
      await updateDreamUser(me.copyWith(friends: listaFriendsMe));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFriend(String id) async {
    try {
      DreamUser? dreamUser = await getDreamUser(id);
      DreamUser? me = await getDreamUser(FirebaseAuth.instance.currentUser!.uid);

      if (dreamUser == null || me == null) return false;

      List<String> listaFriendsDreamUser = dreamUser.friends??[];
      List<String> listaFriendsMe = me.friends??[];

      if (listaFriendsDreamUser.contains(me.id)) listaFriendsDreamUser.remove(me.id);
      if (listaFriendsMe.contains(dreamUser.id??"")) listaFriendsMe.remove(dreamUser.id??"");

      await updateDreamUser(dreamUser.copyWith(friends: listaFriendsDreamUser));
      await updateDreamUser(me.copyWith(friends: listaFriendsMe));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteUser(String uid) async {
    // Eliminar todos los documentos de la subcoleccion 'dream'
    final dreamCollection = _getUserCollection()
        .doc(uid)
        .collection('dream');

    final dreamsSnapshot = await dreamCollection.get();
    for (var doc in dreamsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Eliminar el documento del usuario
    await FirebaseFirestore.instance.collection('user').doc(uid).delete();
  }

  Future<bool> desbloqUser(String id) async {
    DreamUser? dreamUser = await getDreamUser(
        FirebaseAuth.instance.currentUser?.uid ?? "");

    if (dreamUser != null) {
      dreamUser.blocked?.remove(id);
      await updateDreamUser(dreamUser);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> bloqUser(String? id) async {
    DreamUser? dreamUser = await getDreamUser(
        FirebaseAuth.instance.currentUser?.uid ?? "");

    if (dreamUser != null || id != null) {
      dreamUser?.blocked?.add(id!);
      await updateDreamUser(dreamUser!);
      await deleteFriend(id!);
      await deleteFriendRequest(id);
      return true;
    } else {
      return false;
    }
  }
}