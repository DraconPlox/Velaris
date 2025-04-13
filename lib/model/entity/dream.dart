import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream.g.dart';

@JsonSerializable()
class Dream {
  String? id;
  DateTime? fecha;
  String? titulo;
  String? descripcion;
  DateTime? horaInicio;
  DateTime? horaFinal;
  String? caracteristica;
  int? calidad;
  bool? lucido;

  Dream({
    this.id,
    this.fecha,
    this.titulo,
    this.descripcion,
    this.horaInicio,
    this.horaFinal,
    this.caracteristica,
    this.calidad,
    this.lucido,
  });

  @override
  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DreamToJson(this);

  Dream copyWith({
    String? id,
    DateTime? fecha,
    String? titulo,
    String? descripcion,
    DateTime? horaInicio,
    DateTime? horaFinal,
    String? caracteristica,
    int? calidad,
    bool? lucido,
  }) {
    return Dream(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFinal: horaFinal ?? this.horaFinal,
      caracteristica: caracteristica ?? this.caracteristica,
      calidad: calidad ?? this.calidad,
      lucido: lucido ?? this.lucido,
    );
  }


}
