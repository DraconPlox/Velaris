import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:velaris/utils/timestamp_converter.dart';

part 'dream_user.g.dart';

@JsonSerializable()
class DreamUser {
  String? id;
  String? nickname;
  String? search_nickname;
  String? gender;
  String? email;
  String? description;
  String? profilePicture;
  @TimestampConverter()
  DateTime? dob;
  List<String>? friends;
  List<String>? blocked;

  DreamUser({
    this.id,
    this.nickname,
    this.search_nickname,
    this.gender,
    this.email,
    this.description,
    this.profilePicture,
    this.dob,
    this.friends,
    this.blocked,
  });

  @override
  factory DreamUser.fromJson(Map<String, dynamic> json) =>
      _$DreamUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DreamUserToJson(this);

  DreamUser copyWith({
    String? id,
    String? nickname,
    String? search_nickname,
    String? gender,
    String? email,
    String? description,
    String? profilePicture,
    DateTime? dob,
    List<String>? friends,
    List<String>? blocked,
  }) {
    return DreamUser(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      search_nickname: search_nickname ?? this.search_nickname,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      description: description ?? this.description,
      profilePicture: profilePicture ?? this.profilePicture,
      dob: dob ?? this.dob,
      friends: friends ?? this.friends,
      blocked: blocked ?? this.blocked,
    );
  }
}
