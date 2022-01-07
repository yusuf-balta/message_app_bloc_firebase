import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeService {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String endPoint;
  late DatabaseReference ref;
  HomeService() {
    endPoint = 'users';
    ref = FirebaseDatabase.instance.ref(endPoint);
  }

  Future<DatabaseEvent> get() async {
    DatabaseEvent event = await ref.once();
    return event;
  }

  Future<void> logoutUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
