import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/model/entity/dream.dart';

import '../../../service/firestore_service.dart';

class ListDreamsController {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }
}