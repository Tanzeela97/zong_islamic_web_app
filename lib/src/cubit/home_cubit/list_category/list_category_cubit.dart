import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/cate_info.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';

part 'list_category_state.dart';

class ListCategoryCubit extends Cubit<ListCategoryState> {
  final HomeRepository homeRepository;

  ListCategoryCubit(this.homeRepository) : super(InitialListCategoryState());

  void newFetchCategoryStatus(String number) async {
    emit(ListCategoryLoadingState());
    final Either<ListCategoryErrorState, List<CateInfo>> eitherResponse =
        await homeRepository.newFetchCategoryStatus(number);

    emit(eitherResponse.fold(
      (l) => ListCategoryErrorState(),
      (r) => ListCategorySuccessState(cateInfo: r),
    ));
  }

  void fetchFourContentCategoryStatus(String number) async {
    emit(FourCategoryLoadingState());
    final Either<FourCategoryErrorState, List<News>> eitherResponse =
        await homeRepository.fetchFourContentCategoryStatus(number);
    emit(eitherResponse.fold(
      (l) => FourCategoryErrorState(),
      (r) => FourCategorySuccessState(cateInfo: r),
    ));
  }
}
