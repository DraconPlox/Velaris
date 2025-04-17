import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class ViewDreamController {
  FirestoreService firestoreService = FirestoreService();

  Future<Dream?> getDream(String dreamId) {
    return firestoreService.getDream(FirebaseAuth.instance.currentUser!.uid, dreamId);
  }

  Future deleteDream(String dreamId) async {
    await firestoreService.deleteDream(FirebaseAuth.instance.currentUser!.uid, dreamId);
  }
}