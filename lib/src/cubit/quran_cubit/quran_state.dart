part of 'quran_cubit.dart';

@immutable
abstract class QuranState {}

class QuranInitialState extends QuranState {}

class QuranLoadingState extends QuranState {}

class QuranSuccessState extends QuranState {
  QuranSuccessState();
}

class QuranErrorState extends QuranState {
  final String? message;

  QuranErrorState({this.message});
}
