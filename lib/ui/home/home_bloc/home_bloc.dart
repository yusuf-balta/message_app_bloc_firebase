import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/model/person_model.dart';
import 'package:message_app/ui/home/home_bloc/home_event.dart';
import 'package:message_app/ui/home/home_bloc/home_state.dart';
import 'package:message_app/ui/home/home_services/home_services.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeService homeService = HomeService();
  HomeBloc() : super(InitialHomeState()) {
    final stre = FirebaseDatabase.instance.ref('users').onValue.listen((event) {
      add(InitialHomeEvent());
      print(event.snapshot.value);
    });
    stre;
    on(homeEventControl);
  }

  Future<void> homeEventControl(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is InitialHomeEvent) {
      emit(LoadingHomeState());
      List<PersonModel> personModel = [];
      try {
        final event = await homeService.get();
        personModel = (event.snapshot.value as Map)
            .values
            .map((entry) => PersonModel.fromMap(entry))
            .toList();

        emit(SuccsesHomeState(personModel: personModel));
      } catch (e) {
        print(e);
      }
    } else if (event is LogoutHomeEvent) {
      try {
        await homeService.logoutUser();
        emit(LogoutSuccsesHomeState());
      } catch (e) {}
    } else if (event is ChangedAppBarHomeEvent) {
      print(event.currentUser);
      emit(SuccsesChangeAppBar(currentUser: event.currentUser));
    }
  }
}
