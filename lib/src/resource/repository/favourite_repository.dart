

import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class FavouriteRepository {
  static FavouriteRepository? _favouriteRepository;

  static FavouriteRepository? getInstance() {
    _favouriteRepository ??= FavouriteRepository();
    return _favouriteRepository;
  }

  final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<FavouriteError, List<A>>> setAndGetFavorite([String? nameId, int? status,String? number]) async {

    try {
      final favouriteList = await _remoteDataSource.setAndGetFavorite(nameId,status,number);
      return Right(favouriteList);
    } on ServerException {
      return Left(FavouriteError(message: 'Bummer'));
    } on Exception {
      return Left(FavouriteError(message: 'Bummer'));
    }
  }
}
