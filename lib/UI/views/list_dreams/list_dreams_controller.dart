import 'package:velaris/model/entity/dream.dart';

import '../../../service/firestore_service.dart';

class ListDreamsController {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams("nWVi248EOz2dXpgx0dAz");
  }
}