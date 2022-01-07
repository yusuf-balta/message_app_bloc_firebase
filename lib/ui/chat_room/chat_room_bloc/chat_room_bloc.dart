import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/model/message_model.dart';
import 'package:message_app/ui/chat_room/chat_room_bloc/chat_room_event.dart';
import 'package:message_app/ui/chat_room/chat_room_bloc/chat_room_state.dart';
import 'package:message_app/ui/chat_room/chat_room_services/chat_room_service.dart';
import 'package:uuid/uuid.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final String userId;
  final uuid = Uuid();
  FirebaseAuth auth = FirebaseAuth.instance;
  ChatRoomService chatRoomService = ChatRoomService();
  ChatRoomBloc({required this.userId}) : super(InitialChatRoomState()) {
    final stre = FirebaseDatabase.instance
        .ref('chats')
        .child(auth.currentUser!.uid)
        .child(userId)
        .onValue
        .listen((event) {
      add(InitialChatRoomEvent(uuid: userId));
    });

    stre;
    on(chatRoomEventControl);
  }
  Future<void> chatRoomEventControl(
      ChatRoomEvent event, Emitter<ChatRoomState> emit) async {
    if (event is InitialChatRoomEvent) {
      List<MessageModel> messageModels = [];
      final databaseEvent = await chatRoomService.get(event.uuid);
      if (databaseEvent.snapshot.value != null) {
        messageModels = (databaseEvent.snapshot.value as Map)
            .values
            .map((entry) => MessageModel.fromMap(entry))
            .toList();
        messageModels.sort((a, b) => b.createdTime!.millisecondsSinceEpoch
            .compareTo(a.createdTime!.millisecondsSinceEpoch));
      }
      emit(InitialSuccsesChatRoomState(messageModel: messageModels));
    } else if (event is SendMessageChatRoomEvent) {
      event.messageModel.userId = auth.currentUser!.uid;
      event.messageModel.uuid = uuid.v1();

      await chatRoomService.add(event.uuid, event.messageModel);
      await chatRoomService.addd(event.uuid, event.messageModel);
    }
  }

  bool isMe(String uuid) {
    if (auth.currentUser!.uid == uuid) {
      return true;
    }
    return false;
  }
}
