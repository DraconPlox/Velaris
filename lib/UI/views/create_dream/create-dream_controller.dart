import 'package:velaris/service/firestore_service.dart';

import '../../../model/entity/dream.dart';

class CreateDreamController {
  FirestoreService firestoreService = FirestoreService();

  createDream({
    required String titulo,
    required String descripcion,
    required DateTime? horaInicio,
    required DateTime? horaFinal,
    required String? caracteristica,
    required int calidad,
    required bool lucido,
  }) {
    Dream dream = Dream(
      calidad: calidad,
      caracteristica: caracteristica,
      descripcion: descripcion,
      horaFinal: horaFinal,
      horaInicio: horaInicio,
      lucido: lucido,
      titulo: titulo,
    );
    firestoreService.createDream(dream, "nWVi248EOz2dXpgx0dAz");
  }
}
