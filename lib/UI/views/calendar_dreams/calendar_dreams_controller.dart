import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:velaris/service/notification_service.dart';

import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class CalendarDreamsController {
  FirestoreService firestoreService = FirestoreService();
  NotificationService notificationService = NotificationService();
  static bool subscribedToUser = false;

  void initialize() {
    notificationService.scheduleDailyNotification();
    if (!subscribedToUser) subscribeToUserTopic();
  }

  void subscribeToUserTopic() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.subscribeToTopic('user_${FirebaseAuth.instance.currentUser?.uid}');
    subscribedToUser = true;
  }

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }

  Stream<List<Dream>> listenerDreams() {
    return firestoreService.listenToDreams();
  }
}