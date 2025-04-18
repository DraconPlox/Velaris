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
    required String titulo,
    required DateTime fecha,
    required String descripcion,
    required DateTime? horaInicio,
    required DateTime? horaFinal,
    required String? caracteristica,
    required int calidad,
    required bool lucido,
  }) async {
    Dream dream = Dream(
      id: dreamId,
      fecha: fecha,
      calidad: calidad,
      caracteristica: caracteristica,
      descripcion: descripcion,
      horaFinal: horaFinal,
      horaInicio: horaInicio,
      lucido: lucido,
      titulo: titulo,
    );
    await firestoreService.updateDream(dream, FirebaseAuth.instance.currentUser!.uid);
  }
}