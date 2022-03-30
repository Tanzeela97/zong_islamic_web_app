import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/quran_planner.dart';
import 'package:zong_islamic_web_app/src/resource/repository/quran_planner_repository.dart';

part 'quran_state.dart';

class InsertQuranPlannerCubit extends Cubit<QuranPlannerState> {
  QuranPlannerRepository quranRepository;

  InsertQuranPlannerCubit(this.quranRepository) : super(QuranPlannerInitialState());

  void insertQuranPlaner(
      {required String number,
      required String counterQuran,
      required String daysRead,
      required String totalPage,
      required String pageReadMints}) async {
    emit(QuranPlannerLoadingState());
    final eitherResponse = await quranRepository.insertQuranPlaner(
        number, counterQuran, daysRead, totalPage, pageReadMints);
    emit(eitherResponse.fold(
      (l) => QuranPlannerErrorState(message: 'Something Went Wrong'),
      (r) => QuranPlannerSuccessState(),
    ));
  }

  void getQuranPlanner({String? number}) async {
    emit(QuranPlannerLoadingState());
    final eitherResponse = await quranRepository.getQuranPlanner(number: number);
    emit(eitherResponse.fold(
          (l) => QuranPlannerErrorState(message: 'Something Went Wrong'),
          (r) => QuranPlannerSuccessStatePlanner(quranPlanner: r),
    ));
  }

  void updateQuranPlanner({String? number,required String pageRead})async{
    emit(QuranPlannerLoadingState());
    final eitherResponse = await quranRepository.updateQuranPlanner(number, pageRead);
    emit(eitherResponse.fold(
          (l) => QuranPlannerErrorState(message: 'Something Went Wrong'),
          (r) => QuranPlannerSuccessStatePlanner(quranPlanner: r),
    ));
  }


}
