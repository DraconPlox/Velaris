import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:velaris/service/notification_service.dart';

import '../../../main.dart';
import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class CalendarDreamsController {
  FirestoreService firestoreService = FirestoreService();
  NotificationService notificationService = NotificationService(FlutterLocalNotificationsPlugin());
  static bool subscribedToUser = false;

  void initialize() {
    notificationService.scheduleDailyNotification();
    if (!subscribedToUser) subscribeToUserTopic();

    /*flutterLocalNotificationsPlugin.show(
      0,
      'Test',
      'Esto es una prueba',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );*/
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