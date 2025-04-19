// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
  id: json['id'] as String?,
  fecha: const TimestampConverter().fromJson(json['fecha']),
  titulo: json['titulo'] as String?,
  descripcion: json['descripcion'] as String?,
  horaInicio: const TimestampConverter().fromJson(json['horaInicio']),
  horaFinal: const TimestampConverter().fromJson(json['horaFinal']),
  caracteristica: json['caracteristica'] as String?,
  calidad: (json['calidad'] as num?)?.toInt(),
  lucido: json['lucido'] as bool?,
);

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
  'id': instance.id,
  'fecha': _$JsonConverterToJson<dynamic, DateTime>(
    instance.fecha,
    const TimestampConverter().toJson,
  ),
  'titulo': instance.titulo,
  'descripcion': instance.descripcion,
  'horaInicio': _$JsonConverterToJson<dynamic, DateTime>(
    instance.horaInicio,
    const TimestampConverter().toJson,
  ),
  'horaFinal': _$JsonConverterToJson<dynamic, DateTime>(
    instance.horaFinal,
    const TimestampConverter().toJson,
  ),
  'caracteristica': instance.caracteristica,
  'calidad': instance.calidad,
  'lucido': instance.lucido,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
