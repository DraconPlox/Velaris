import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/entity/dream.dart';
import '../model/entity/dream_user.dart';

class FirestoreService {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  Future<String?> getDescription(String userId) async {
    try {
      // Espera que se complete la operación y obtén el documento
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .get();

      // Verifica si el documento existe
      if (userDoc.exists) {
        // Retorna el valor de 'description' si existe
        return userDoc['description'];
      } else {
        print('Usuario no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener la descripción: $e');
      return null;
    }
  }

  Future<String?> getGender(String userId) async {
    try {
      // Espera que se complete la operación y obtén el documento
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .get();

      // Verifica si el documento existe
      if (userDoc.exists) {
        // Retorna el valor de 'description' si existe
        return userDoc['gender'];
      } else {
        print('Usuario no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener la descripción: $e');
      return null;
    }
  }

  Future<DateTime?> getDob(String userId) async {
    try {
      // Espera que se complete la operación y obtén el documento
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .get();

      // Verifica si el documento existe
      if (userDoc.exists) {
        // Si el campo 'dob' es un Timestamp, conviértelo a DateTime
        Timestamp dobTimestamp = userDoc['dob'];
        DateTime dob = dobTimestamp.toDate();
        return dob;
      } else {
        print('Usuario no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener la fecha de nacimiento: $e');
      return null;
    }
  }

  Future<String?> getNickname(String userId) async {
    try {
      // Espera que se complete la operación y obtén el documento
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .get();

      // Verifica si el documento existe
      if (userDoc.exists) {
        // Retorna el valor de 'description' si existe
        return userDoc['nickname'];
      } else {
        print('Usuario no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener la descripción: $e');
      return null;
    }
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

  CollectionReference<Map<String, dynamic>> _getUserCollection() {
    return _ref.collection("user");
  }

  Future<List<DreamUser>> searchUsers(String query) async {
    final snapshot = await _getUserCollection()
        .where('nickname', isGreaterThanOrEqualTo: query)
        .where('nickname', isLessThanOrEqualTo: query + '\uf8ff')
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
}