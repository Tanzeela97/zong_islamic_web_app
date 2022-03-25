part of 'quran_cubit.dart';

@immutable
abstract class QuranPlannerState {
  const QuranPlannerState();
}

class QuranPlannerInitialState extends QuranPlannerState {}

class QuranPlannerLoadingState extends QuranPlannerState {}

class QuranPlannerSuccessState extends QuranPlannerState {
  QuranPlannerSuccessState();
}

class QuranPlannerSuccessStatePlanner extends QuranPlannerState {
  final QuranPlanner quranPlanner;

  const QuranPlannerSuccessStatePlanner({required this.quranPlanner});
}

class QuranPlannerErrorState extends QuranPlannerState {
  final String? message;

  QuranPlannerErrorState({this.message});
}
