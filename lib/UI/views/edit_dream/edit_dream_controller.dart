import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class EditDreamController {
  FirestoreService firestoreService = FirestoreService();

  Future<Dream?> getDream(String dreamId) {
    return firestoreService.getDream(FirebaseAuth.instance.currentUser!.uid, dreamId);
  }

  Future updateDream({
    required String dreamId,
    required String title,
    required DateTime date,
    required String description,
    required DateTime? dreamStart,
    required DateTime? dreamEnd,
    required String? tag,
    required int rating,
    required bool lucid,
  }) async {
    Dream dream = Dream(
      id: dreamId,
      date: date,
      rating: rating,
      tag: tag,
      description: description,
      dreamStart: dreamStart,
      dreamEnd: dreamEnd,
      lucid: lucid,
      title: title,
    );
    await firestoreService.updateDream(dream, FirebaseAuth.instance.currentUser!.uid);
  }
}