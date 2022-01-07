import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/model/person_model.dart';
import 'package:message_app/ui/chat_room/chat_room.dart';
import 'package:message_app/ui/home/home_bloc/home_bloc.dart';
import 'package:message_app/ui/home/home_bloc/home_event.dart';
import 'package:message_app/ui/home/home_bloc/home_state.dart';
import 'package:message_app/ui/login/login_ui/login_screen.dart';
import 'package:message_app/ui/utils/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUser = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = true;
  late HomeBloc homeBloc;
  List<PersonModel> personModels = [];

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is SuccsesHomeState) {
          personModels.clear();
          personModels = state.personModel;
          setState(() {
            isLoading = false;
          });
        } else if (state is LogoutSuccsesHomeState) {
          Routter.pushReplacement(LoginScreen(), context);
        } else if (state is SuccsesChangeAppBar) {
          print(state.currentUser);
          setState(() {
            currentUser = state.currentUser;
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: currentUser == '' ? null : Text(currentUser),
            actions: [
              IconButton(
                  onPressed: () {
                    homeBloc.add(LogoutHomeEvent());
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: personModels.length,
                  itemBuilder: (context, index) {
                    final personModel = personModels[index];
                    if (auth.currentUser!.uid == personModel.userId) {
                      homeBloc.add(ChangedAppBarHomeEvent(
                          currentUser: personModel.userName!));
                      return SizedBox();
                    }
                    return GestureDetector(
                      onTap: () {
                        Routter.push(
                            ChatRoom(personModel: personModel), context);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25)),
                            height: 50,
                            width: 50,
                          ),
                          subtitle: personModel.newMesage!
                              ? const Text('Yeni Mesaj')
                              : null,
                          trailing: Text(personModel.createdTime!.toString()),
                          title: Text(personModel.userName!),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
