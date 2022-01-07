import 'dart:convert';

class MessageModel {
  String? uuid;
  String? userId;
  String? message;
  DateTime? createdTime;
  MessageModel({
    this.uuid,
    this.userId,
    this.message,
    this.createdTime,
  });

  MessageModel copyWith({
    String? uuid,
    String? userId,
    String? message,
    DateTime? createdTime,
  }) {
    return MessageModel(
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'userId': userId,
      'message': message,
      'createdTime': createdTime?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<dynamic, dynamic> map) {
    return MessageModel(
      uuid: map['uuid'],
      userId: map['userId'],
      message: map['message'],
      createdTime: map['createdTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdTime'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(uuid: $uuid, userId: $userId, message: $message, createdTime: $createdTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.message == message &&
        other.createdTime == createdTime;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        userId.hashCode ^
        message.hashCode ^
        createdTime.hashCode;
  }
}
