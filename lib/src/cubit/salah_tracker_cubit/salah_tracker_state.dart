part of 'salah_tracker_cubit.dart';



@immutable
abstract class SalahTrackerState {
  const SalahTrackerState();
}

class SalahTrackerInitial extends SalahTrackerState {
  const SalahTrackerInitial();
}
class SalahTrackerLoading extends SalahTrackerState {
  const SalahTrackerLoading();
}
class SalahTrackerSuccess extends SalahTrackerState {
  const SalahTrackerSuccess();
}
class SalahTrackerSuccessGet extends SalahTrackerState {
  final List<SalahTracker> salahTracker;
  const SalahTrackerSuccessGet({required this.salahTracker});
}
class SalahTrackerError extends SalahTrackerState {
  const SalahTrackerError();
}
