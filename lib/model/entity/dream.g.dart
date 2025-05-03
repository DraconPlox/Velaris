// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
  id: json['id'] as String?,
  date: const TimestampConverter().fromJson(json['date']),
  title: json['title'] as String?,
  description: json['description'] as String?,
  dreamStart: const TimestampConverter().fromJson(json['dreamStart']),
  dreamEnd: const TimestampConverter().fromJson(json['dreamEnd']),
  tag: json['tag'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  lucid: json['lucid'] as bool?,
);

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
  'id': instance.id,
  'date': _$JsonConverterToJson<dynamic, DateTime>(
    instance.date,
    const TimestampConverter().toJson,
  ),
  'title': instance.title,
  'description': instance.description,
  'dreamStart': _$JsonConverterToJson<dynamic, DateTime>(
    instance.dreamStart,
    const TimestampConverter().toJson,
  ),
  'dreamEnd': _$JsonConverterToJson<dynamic, DateTime>(
    instance.dreamEnd,
    const TimestampConverter().toJson,
  ),
  'tag': instance.tag,
  'rating': instance.rating,
  'lucid': instance.lucid,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
