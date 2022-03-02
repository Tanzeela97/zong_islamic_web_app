import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/all_recording_repository.dart';

part 'all_recording_state.dart';

class AllRecordingCubit extends Cubit<AllRecordingState> {
  final AllRecordingRepository allRecordingRepository;

  AllRecordingCubit(this.allRecordingRepository) : super(AllRecordingInitialState());

  void getAllRecording(String number) async {
    emit(AllRecordingLoadingState());
    final Either<AllRecordingErrorState, String> eitherResponse =
        (await allRecordingRepository.getAllRecording(number));
    emit(eitherResponse.fold(
      (l) => AllRecordingErrorState(message: 'Something Went Wrong'),
      (r) => AllRecordingSuccessState(string: r),
    ));
  }
}
