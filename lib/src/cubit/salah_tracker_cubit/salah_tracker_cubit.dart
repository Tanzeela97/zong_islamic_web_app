import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/salah_tracker.dart';
import 'package:zong_islamic_web_app/src/resource/repository/salah_tracker_repository.dart';

part 'salah_tracker_state.dart';

class SalahTrackerCubit extends Cubit<SalahTrackerState> {
  final SalahTrackerRepository salahTrackerRepository;
  SalahTrackerCubit({required this.salahTrackerRepository}) : super(SalahTrackerInitial());

  void postSalahTracker({required String number})async{
    emit(const SalahTrackerLoading());
    final eitherResponse = await salahTrackerRepository.postSalahTracker(number);
    emit(eitherResponse.fold(
          (l) => const SalahTrackerError(),
          (r) => const SalahTrackerSuccess(),
    ));
  }
  void getSalahTracker({required String number})async{
    emit(const SalahTrackerLoading());
    final eitherResponse = await salahTrackerRepository.getSalahTracker(number);
    emit(eitherResponse.fold(
          (l) => const SalahTrackerError(),
          (r) => SalahTrackerSuccessGet(salahTracker: r),
    ));
  }

}
