import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/entity/dream.dart';

class FirestoreService {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  createDream(Dream dream, String userId) async {
    var reference = _getDreamCollection(userId).doc();
    var id = reference.id;
    var saved = dream.copyWith(id: id);

    await _getDreamCollection(userId).doc(id).set(saved.toJson());
  }

  CollectionReference<Map<String, dynamic>> _getDreamCollection(String userId) {
    return _ref.collection("user").doc(userId).collection("dream");
  }
}