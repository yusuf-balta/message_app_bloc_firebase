import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/model/message_model.dart';

class ChatRoomService {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String endPoint;
  late DatabaseReference ref;
  ChatRoomService() {
    endPoint = 'chats';
  }

  Future<DatabaseEvent> get(String uuid) async {
    ref = FirebaseDatabase.instance
        .ref(endPoint)
        .child(auth.currentUser!.uid)
        .child(uuid);
    DatabaseEvent event = await ref.orderByChild('createdTime').once();
    return event;
  }

  Future<String> add(String uuid, MessageModel messageModel) async {
    ref = FirebaseDatabase.instance
        .ref(endPoint)
        .child(auth.currentUser!.uid)
        .child(uuid);
    try {
      await ref.child(messageModel.uuid!).set(messageModel.toMap());
      return 'true';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<String> addd(String uuid, MessageModel messageModel) async {
    ref = FirebaseDatabase.instance
        .ref(endPoint)
        .child(uuid)
        .child(auth.currentUser!.uid);
    try {
      await ref.child(messageModel.uuid!).set(messageModel.toMap());
      return 'true';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
