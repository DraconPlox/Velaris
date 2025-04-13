import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class ViewDreamController {
  FirestoreService firestoreService = FirestoreService();

  Future<Dream?> getDream(String dreamId) {
    return firestoreService.getDream("nWVi248EOz2dXpgx0dAz", dreamId);
  }
}