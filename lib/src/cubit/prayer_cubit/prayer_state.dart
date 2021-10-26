part of 'prayer_cubit.dart';

@immutable
abstract class PrayerState {
  const PrayerState();
}

class PrayerInitial extends PrayerState {
  const PrayerInitial();
}

class PrayerLoadingState extends PrayerState {
  const PrayerLoadingState();
}

class PrayerSuccessState extends PrayerState {
  final PrayerInfo prayerInfo;

  const PrayerSuccessState({required this.prayerInfo});
}

class PrayerErrorState extends PrayerState {
  final String message;

  const PrayerErrorState({required this.message});
}
