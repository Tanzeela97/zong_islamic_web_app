import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/resource/repository/favourite_repository.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository _favouriteRepository;
  FavouriteCubit(this._favouriteRepository) : super(const FavouriteInitial());

  Future<void> setAndGetFavorite([String? nameId, int? status]) async {
    emit(const FavouriteLoading());
    final Either<FavouriteError, List<A>> eitherResponse =
    await _favouriteRepository.setAndGetFavorite(nameId,status);
    emit(eitherResponse.fold(
            (failure) => FavouriteError(message: failure.message),
            (data) => FavouriteLoaded(favoriteList: data)));
  }
}
