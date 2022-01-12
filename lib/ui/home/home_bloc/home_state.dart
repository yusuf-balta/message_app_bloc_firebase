import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:message_app/model/person_model.dart';

abstract class HomeState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class SuccsesHomeState extends HomeState {
  final List<PersonModel> personModel;
  SuccsesHomeState({
    required this.personModel,
  });
}

class LogoutSuccsesHomeState extends HomeState {}

class SuccsesChangeAppBar extends HomeState {
  final String currentUser;
  SuccsesChangeAppBar({
    required this.currentUser,
  });
}
