import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:message_app/local_push_notifications/local_push_notification_helper.dart';
import 'package:message_app/model/message_model.dart';
import 'package:message_app/model/person_model.dart';
import 'package:message_app/ui/SecondPage.dart';
import 'package:message_app/ui/chat_room/chat_room_bloc/chat_room_bloc.dart';
import 'package:message_app/ui/chat_room/chat_room_bloc/chat_room_event.dart';
import 'package:message_app/ui/chat_room/chat_room_bloc/chat_room_state.dart';
import 'package:message_app/ui/home/home_bloc/home_state.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key? key, required this.personModel}) : super(key: key);

  PersonModel personModel;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final notifications = FlutterLocalNotificationsPlugin();
  late TextEditingController? txtMessageControler;
  bool isLoading = true;
  late ChatRoomBloc chatRoomBloc;
  List<MessageModel> messagesModel = [];
  @override
  void initState() {
    super.initState();
    final settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload!));

    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: (payload) => onSelectNotification(payload!));

    chatRoomBloc = ChatRoomBloc(userId: widget.personModel.userId!);
    txtMessageControler = TextEditingController();

    chatRoomBloc.add(InitialChatRoomEvent(uuid: widget.personModel.userId!));
  }

  Future<void> onSelectNotification(String payload) async =>
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
      );

  @override
  void dispose() {
    chatRoomBloc.close();
    txtMessageControler!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: chatRoomBloc,
      listener: (context, state) {
        if (state is InitialSuccsesChatRoomState) {
          setState(() {
            messagesModel = state.messageModel;
            isLoading = false;
          });
        } else if (state is NewMessageState) {
          showOngoingNotification(notifications,
              title: state.message.userId!, body: state.message.message!);
        } else if (state is NewMessageRoomChatRoomState) {
          setState(() {
            print(state.message);
            int length = messagesModel.length;
            messagesModel.insert(0, state.message);
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.personModel.userName!),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    height: size.height * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: size.height * 0.7,
                          child: messagesModel.isNotEmpty
                              ? ListView.builder(
                                  reverse: true,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: messagesModel.length,
                                  itemBuilder: (context, index) {
                                    final message = messagesModel[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 50,
                                        ),
                                        alignment:
                                            chatRoomBloc.isMe(message.userId!)
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: chatRoomBloc
                                                  .isMe(message.userId!)
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20))
                                              : const BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20)),
                                        ),
                                        child: Container(
                                            alignment: chatRoomBloc
                                                    .isMe(message.userId!)
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            width: size.width * 0.8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                message.message!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            )),
                                      ),
                                    );
                                  })
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.75,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Mesaj',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  controller: txtMessageControler,
                                ),
                              ),
                              Container(
                                width: size.width * 0.2,
                                child: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    chatRoomBloc.add(
                                      SendMessageChatRoomEvent(
                                        uuid: widget.personModel.userId!,
                                        messageModel: MessageModel(
                                            createdTime: DateTime.now(),
                                            message: txtMessageControler!.text
                                                .trim()),
                                      ),
                                    );
                                    txtMessageControler!.clear();
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
