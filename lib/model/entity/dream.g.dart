// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dream _$DreamFromJson(Map<String, dynamic> json) => Dream(
  id: json['id'] as String?,
  titulo: json['titulo'] as String?,
  descripcion: json['descripcion'] as String?,
  horaInicio:
      json['horaInicio'] == null
          ? null
          : DateTime.parse(json['horaInicio'] as String),
  horaFinal:
      json['horaFinal'] == null
          ? null
          : DateTime.parse(json['horaFinal'] as String),
  caracteristica: json['caracteristica'] as String?,
  calidad: (json['calidad'] as num?)?.toInt(),
  lucido: json['lucido'] as bool?,
);

Map<String, dynamic> _$DreamToJson(Dream instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descripcion': instance.descripcion,
  'horaInicio': instance.horaInicio?.toIso8601String(),
  'horaFinal': instance.horaFinal?.toIso8601String(),
  'caracteristica': instance.caracteristica,
  'calidad': instance.calidad,
  'lucido': instance.lucido,
};
