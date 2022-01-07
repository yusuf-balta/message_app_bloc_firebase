import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialHomeEvent extends HomeEvent {}

class LogoutHomeEvent extends HomeEvent {}

class ChangedAppBarHomeEvent extends HomeEvent {
  String currentUser;
  ChangedAppBarHomeEvent({
    required this.currentUser,
  });
}
