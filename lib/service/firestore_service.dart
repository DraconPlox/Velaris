import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/entity/dream.dart';

class FirestoreService {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

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
        .orderBy('fecha', descending: true)
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
}