import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:message_app/model/person_model.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialLoginEvent extends LoginEvent {}

class LoadLoginEvent extends LoginEvent {}

class CreateUserLoginEvent extends LoginEvent {
  final PersonModel? personModel;
  CreateUserLoginEvent({this.personModel});
  @override
  List<Object?> get props => [personModel, UniqueKey()];
}

class LoginUserLoginEvent extends LoginEvent {
  final String? email;
  final String? password;
  LoginUserLoginEvent({this.email, this.password});
  @override
  List<Object?> get props => [email, password, UniqueKey()];
}

class PushToHomeScrrenLoginEvent extends LoginEvent {}
