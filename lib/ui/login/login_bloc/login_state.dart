import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialLoginState extends LoginState {}

class SplashLoadingLoginState extends LoginState {}

class SplashLoadedLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {}

class FailedLoginState extends LoginState {}

class CreateUserLoadingLoginState extends LoginState {}

class CreateUserSucssesLoginState extends LoginState {}

class CreateUserFailedLoginState extends LoginState {
  final String error;

  CreateUserFailedLoginState({required this.error});
}

class LoginUserLoadingLoginState extends LoginState {}

class LoginUserSuccsesLoginState extends LoginState {}

class LoginUserFailedLoginState extends LoginState {
  final String error;
  LoginUserFailedLoginState({
    required this.error,
  });
}

class PushToHomeScreenLoginState extends LoginState {}
