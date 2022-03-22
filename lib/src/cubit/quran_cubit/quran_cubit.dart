import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/quran_repository.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranRepository quranRepository;

  QuranCubit(this.quranRepository) : super(QuranInitialState());

  void insertQuranPlaner(String? number, String counterQuran, String daysRead,
      String totalPage, String pageReadMints) async {
    emit(QuranLoadingState());
    final eitherResponse = await quranRepository.insertQuranPlaner(
        number, counterQuran, daysRead, totalPage, pageReadMints);
    emit(eitherResponse.fold(
      (l) => QuranErrorState(message: 'Something Went Wrong'),
      (r) => QuranSuccessState(),
    ));
  }


}
