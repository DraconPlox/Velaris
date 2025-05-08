import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationService(this.flutterLocalNotificationsPlugin);

  Future<void> scheduleDailyNotification(TimeOfDay hour) async {
    tz.initializeTimeZones();
    final madrid = tz.getLocation('Europe/Madrid');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      100,
      'Recordatorio',
      '¡No olvides apuntar el sueño de hoy!',
      _nextInstanceOfHourMadrid(hour.hour, hour.minute, madrid),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification_channel_id',
          'Daily Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_payload',
    );
  }

  tz.TZDateTime _nextInstanceOfHourMadrid(int hour, int minute, tz.Location madrid) {
    final tz.TZDateTime now = tz.TZDateTime.now(madrid);
    tz.TZDateTime scheduledDate = tz.TZDateTime(madrid, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print('Programando para: $scheduledDate');
    return scheduledDate;
  }
}