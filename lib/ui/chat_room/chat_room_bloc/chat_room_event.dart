import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:message_app/model/message_model.dart';

abstract class ChatRoomEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialChatRoomEvent extends ChatRoomEvent {
  final String uuid;
  InitialChatRoomEvent({
    required this.uuid,
  });
}

class SendMessageChatRoomEvent extends ChatRoomEvent {
  final String uuid;
  final MessageModel messageModel;
  SendMessageChatRoomEvent({
    required this.uuid,
    required this.messageModel,
  });
}
