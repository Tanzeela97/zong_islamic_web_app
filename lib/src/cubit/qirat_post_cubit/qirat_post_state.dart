part of 'qirat_post_cubit.dart';

@immutable
abstract class QiratPostState {}

class QiratPostInitial extends QiratPostState {}

class QiratPostLoadingState extends QiratPostState {}

class QiratPostSuccessState extends QiratPostState {
  final String? string;

  QiratPostSuccessState({this.string});
}

class QiratPostErrorState extends QiratPostState {
  final String? message;

  QiratPostErrorState({this.message});
}
