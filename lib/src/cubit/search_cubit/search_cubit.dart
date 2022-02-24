import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRepository searchRepository;

  SearchCubit(this.searchRepository) : super(SearchInitial());

  void getSearchData(String number,[String? search]) async {
    emit(SearchLoadingState());
    final Either<SearchErrorState, Profile> eitherResponse =
        await searchRepository.getSearchData(number,search);
    emit(eitherResponse.fold(
      (l) => SearchErrorState(),
      (r) =>SearchSuccessState(profle: r),
    ));
  }
}
