import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/islamic_name_cubit/islamic_name_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class IslamicNameRepository {
static IslamicNameRepository? _islamicNameRepository;

static IslamicNameRepository? getInstance() {
  _islamicNameRepository ??= IslamicNameRepository();
return _islamicNameRepository;
}

final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();

Future<Either<IslamicNameError, IslamicNameModel>> getIslamicName(String url) async {

  try {
    final islamicName = await _remoteDataSource.getIslamicName(url);
    return Right(islamicName);
  } on ServerException {
    return Left(IslamicNameError(message: 'Bummer'));
  } on Exception {
    return Left(IslamicNameError(message: 'Bummer'));
  }
}
}
