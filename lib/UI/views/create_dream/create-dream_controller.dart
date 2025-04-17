import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class CreateDreamController {
  FirestoreService firestoreService = FirestoreService();

  Future<String> createDream({
    required String titulo,
    required DateTime fecha,
    required String descripcion,
    required DateTime? horaInicio,
    required DateTime? horaFinal,
    required String? caracteristica,
    required int calidad,
    required bool lucido,
  }) {
    Dream dream = Dream(
      fecha: fecha,
      calidad: calidad,
      caracteristica: caracteristica,
      descripcion: descripcion,
      horaFinal: horaFinal,
      horaInicio: horaInicio,
      lucido: lucido,
      titulo: titulo,
    );
    return firestoreService.createDream(dream, FirebaseAuth.instance.currentUser!.uid);
  }
}
