import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class CalendarDreamsController {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }
}