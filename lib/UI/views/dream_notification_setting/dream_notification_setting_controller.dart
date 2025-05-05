import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:velaris/service/shared_preferences_service.dart';

class DreamNotificationSettingController {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  Future<void> initialize() async {
    await sharedPreferencesService.init();
  }

  Future<void> setHour(TimeOfDay hour) async {
    sharedPreferencesService.hour = "${hour.hour}:${hour.minute}";
  }

  Future<TimeOfDay> getHour() async {
    String stringTod = sharedPreferencesService.hour??"08:00";
    List<String> lista = stringTod.split(":");
    return TimeOfDay(hour: int.parse(lista[0]), minute: int.parse(lista[1]));
  }

  Future<void> setHourActivation(bool activation) async {
    sharedPreferencesService.hourActivation = activation;
  }

  Future<bool?> getHourActivation() async {
    return sharedPreferencesService.hourActivation;
  }

}