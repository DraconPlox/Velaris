import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:velaris/utils/timestamp_converter.dart';

part 'dream_user.g.dart';

@JsonSerializable()
class DreamUser {
  String? id;
  String? nickname;
  String? gender;
  String? email;
  String? description;
  String? profilePicture;
  @TimestampConverter()
  DateTime? dob;
  List<String>? friends;

  DreamUser({
    this.id,
    this.nickname,
    this.gender,
    this.email,
    this.description,
    this.profilePicture,
    this.dob,
    this.friends,
  });

  @override
  factory DreamUser.fromJson(Map<String, dynamic> json) =>
      _$DreamUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DreamUserToJson(this);

  DreamUser copyWith({
    String? id,
    String? nickname,
    String? gender,
    String? email,
    String? description,
    String? profilePicture,
    DateTime? dob,
    List<String>? friends,
  }) {
    return DreamUser(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      description: description ?? this.description,
      profilePicture: profilePicture ?? this.profilePicture,
      dob: dob ?? this.dob,
      friends: friends ?? this.friends,
    );
  }
}
