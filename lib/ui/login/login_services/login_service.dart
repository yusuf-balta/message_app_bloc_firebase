import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/model/person_model.dart';

class LoginService {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String endPoint;
  late DatabaseReference ref;
  LoginService() {
    endPoint = 'users';
    ref = FirebaseDatabase.instance.ref(endPoint);
  }

  Future<String> createUser(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> addUser(
      {required PersonModel personModel, required String uuid}) async {
    try {
      await ref.child(uuid).set(personModel.toMap());
      return 'true';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>>${e.code}");
      return e.code;
    }
  }

  Future<void> logoutUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
