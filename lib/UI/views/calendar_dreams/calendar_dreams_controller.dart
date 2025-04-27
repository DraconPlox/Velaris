import 'package:firebase_auth/firebase_auth.dart';
import 'package:velaris/service/notification_service.dart';

import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class CalendarDreamsController {
  FirestoreService firestoreService = FirestoreService();
  NotificationService notificationService = NotificationService();

  void initialize() {
    notificationService.scheduleDailyNotification();
  }

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }

  Stream<List<Dream>> listenerDreams() {
    return firestoreService.listenToDreams();
  }
}