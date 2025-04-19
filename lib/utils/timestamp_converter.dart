import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json == null) return DateTime.now();

    // Firebase Timestamp tiene método toDate()
    if (json is Timestamp) {
      return json.toDate();
    }

    // Si es un string o int, lo intentamos convertir directamente
    if (json is String) {
      return DateTime.parse(json);
    }

    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }

    throw Exception("Unsupported timestamp format: $json");
  }

  @override
  dynamic toJson(DateTime date) => date.toIso8601String();
}
