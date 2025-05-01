import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/timestamp_converter.dart';

part 'dream.g.dart';

@JsonSerializable()
class Dream {
  String? id;
  @TimestampConverter()
  DateTime? date;
  String? title;
  String? description;
  @TimestampConverter()
  DateTime? dreamStart;
  @TimestampConverter()
  DateTime? dreamEnd;
  String? tag;
  int? rating;
  bool? lucid;

  Dream({
    this.id,
    this.date,
    this.title,
    this.description,
    this.dreamStart,
    this.dreamEnd,
    this.tag,
    this.rating,
    this.lucid,
  });

  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

  Map<String, dynamic> toJson() => _$DreamToJson(this);

  Dream copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? description,
    DateTime? dreamStart,
    DateTime? dreamEnd,
    String? tag,
    int? rating,
    bool? lucid,
  }) {
    return Dream(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      dreamStart: dreamStart ?? this.dreamStart,
      dreamEnd: dreamEnd ?? this.dreamEnd,
      tag: tag ?? this.tag,
      rating: rating ?? this.rating,
      lucid: lucid ?? this.lucid,
    );
  }
}