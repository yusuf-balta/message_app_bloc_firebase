import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:message_app/model/message_model.dart';

abstract class ChatRoomState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialChatRoomState extends ChatRoomState {}

class InitialSuccsesChatRoomState extends ChatRoomState {
  final List<MessageModel> messageModel;
  InitialSuccsesChatRoomState({
    required this.messageModel,
  });
}

class SendChatRoomState extends ChatRoomState {}
