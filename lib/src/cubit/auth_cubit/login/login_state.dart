part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final AuthStatusModel? authStatusModel;
  LoginSuccessState({this.authStatusModel});
}

class LoginErrorState extends LoginState{
  final String? message;

  LoginErrorState({this.message});
}
