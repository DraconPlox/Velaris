import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:velaris/service/notification_service.dart';
import 'package:velaris/service/shared_preferences_service.dart';

import '../../../main.dart';
import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class CalendarDreamsController {
  FirestoreService firestoreService = FirestoreService();
  NotificationService notificationService = NotificationService(FlutterLocalNotificationsPlugin());
  static bool subscribedToUser = false;
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<TimeOfDay> getHour() async {
    String stringTod = sharedPreferencesService.hour??"08:00";
    List<String> lista = stringTod.split(":");
    return TimeOfDay(hour: int.parse(lista[0]), minute: int.parse(lista[1]));
  }

  void initialize() async {
    await sharedPreferencesService.init();
    if (sharedPreferencesService.hourActivation??true) {
      notificationService.scheduleDailyNotification(await getHour());
    }
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