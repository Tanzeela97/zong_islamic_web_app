import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/all_recording_repository.dart';

part 'qirat_post_state.dart';

class QiratPostCubit extends Cubit<QiratPostState> {
  final AllRecordingRepository allRecordingRepository;

  QiratPostCubit(this.allRecordingRepository) : super(QiratPostInitial());

  void getAllRecording(String filePath) async {
    emit(QiratPostLoadingState());
    final Either<QiratPostErrorState, String> eitherResponse =
        (await allRecordingRepository.postQirat(filePath));
    emit(eitherResponse.fold(
      (l) => QiratPostErrorState(message: 'Something Went Wrong'),
      (r) => QiratPostSuccessState(string: r),
    ));
  }
}
