part of 'quran_cubit.dart';

@immutable
abstract class QuranPlannerState {
  const QuranPlannerState();
}

class QuranPlannerInitialState extends QuranPlannerState {
  const QuranPlannerInitialState();
}

class QuranPlannerLoadingState extends QuranPlannerState {
  const QuranPlannerLoadingState();
}

class QuranPlannerSuccessState extends QuranPlannerState {
  const QuranPlannerSuccessState();
}

class QuranPlannerSuccessStatePlanner extends QuranPlannerState {
  final QuranPlanner quranPlanner;

  const QuranPlannerSuccessStatePlanner({required this.quranPlanner});
}

class QuranPlannerErrorState extends QuranPlannerState {
  final String? message;

  const QuranPlannerErrorState({this.message});
}
