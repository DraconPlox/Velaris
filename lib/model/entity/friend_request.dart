import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request.g.dart';

@JsonSerializable()
class FriendRequest {
  String? id;
  String? senderId;
  String? receiverId;

  FriendRequest({
    this.id,
    this.senderId,
    this.receiverId
  });

  @override
  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FriendRequestToJson(this);

  FriendRequest copyWith({
    String? id,
    String? senderId,
    String? receiverId,
  }) {
    return FriendRequest(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
    );
  }
}