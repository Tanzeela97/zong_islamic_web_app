part of 'all_recording_cubit.dart';

@immutable
abstract class AllRecordingState {}

class AllRecordingInitialState extends AllRecordingState {}

class AllRecordingLoadingState extends AllRecordingState {}

class AllRecordingSuccessState extends AllRecordingState {
  final String? string;

  AllRecordingSuccessState({this.string});
}

class AllRecordingErrorState extends AllRecordingState {
  final String? message;

  AllRecordingErrorState({this.message});
}
