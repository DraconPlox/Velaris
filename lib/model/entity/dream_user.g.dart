// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DreamUser _$DreamUserFromJson(Map<String, dynamic> json) => DreamUser(
  id: json['id'] as String?,
  nickname: json['nickname'] as String?,
  gender: json['gender'] as String?,
  email: json['email'] as String?,
  description: json['description'] as String?,
  dob: const TimestampConverter().fromJson(json['dob']),
  friends:
      (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$DreamUserToJson(DreamUser instance) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'gender': instance.gender,
  'email': instance.email,
  'description': instance.description,
  'dob': _$JsonConverterToJson<dynamic, DateTime>(
    instance.dob,
    const TimestampConverter().toJson,
  ),
  'friends': instance.friends,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
