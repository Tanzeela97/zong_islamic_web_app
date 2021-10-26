import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/resource/repository/prayer_repository.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerRepository _prayerRepository;
  PrayerCubit(this._prayerRepository) : super(const PrayerInitial());

  void getPrayer() async {
    emit(const PrayerLoadingState());
    final Either<PrayerErrorState, PrayerInfo> eitherResponse =
    await _prayerRepository.getPrayerInfo();
    emit(eitherResponse.fold(
          (l) => const PrayerErrorState(message: 'Something Went Wrong'),
          (r) => PrayerSuccessState(prayerInfo: r),
    ));
  }
}
