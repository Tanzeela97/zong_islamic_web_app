part of 'islamic_name_cubit.dart';

@immutable
abstract class IslamicNameState {
  const IslamicNameState();
}

class IslamicNameInitial extends IslamicNameState {
  const IslamicNameInitial();
}

class IslamicNameLoading extends IslamicNameState {
  const IslamicNameLoading();
}

class IslamicNameLoaded extends IslamicNameState {
  final IslamicNameModel islamicNameModel;

  const IslamicNameLoaded({required this.islamicNameModel});
}

class IslamicNameError extends IslamicNameState {
  final String message;

  IslamicNameError({required this.message});
}
