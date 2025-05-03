import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class CreateDreamController {
  FirestoreService firestoreService = FirestoreService();

  Future<String> createDream({
    required String title,
    required DateTime date,
    required String description,
    required DateTime? dreamStart,
    required DateTime? dreamEnd,
    required String? tag,
    required int rating,
    required bool lucid,
  }) {
    Dream dream = Dream(
      date: date,
      rating: rating,
      tag: tag,
      description: description,
      dreamStart: dreamStart,
      dreamEnd: dreamEnd,
      lucid: lucid,
      title: title,
    );
    return firestoreService.createDream(dream, FirebaseAuth.instance.currentUser!.uid);
  }
}
