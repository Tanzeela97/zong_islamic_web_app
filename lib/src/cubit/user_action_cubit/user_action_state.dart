part of 'user_action_cubit.dart';

@immutable
abstract class UserActionState {
  const UserActionState();
}

class UserActionInitial extends UserActionState {
  const UserActionInitial();
}
class UserActionLoading extends UserActionState {
  const UserActionLoading();
}
class UserActionLoaded extends UserActionState {
  final UserAction userAction;
  const UserActionLoaded({required this.userAction});
}
class UserActionError extends UserActionState {
  const UserActionError();
}
