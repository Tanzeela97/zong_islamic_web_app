import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/zong_app_info_cubit/zong_app_info_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/zong_app_info.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class ZongAppInfoRepository {
  static ZongAppInfoRepository? _repository;

  static ZongAppInfoRepository? getInstance() {
    _repository ??= ZongAppInfoRepository();
    return _repository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<ZongAppInfoError, ZongAppInformation>> getZongAppInfo(String number) async {
    try {
      final zongAppInfo = await remoteDataSource.getZongAppInfo(number);
      return Right(zongAppInfo);
    } on ServerException {
      return Left(ZongAppInfoError());
    } on Exception {
      return Left(ZongAppInfoError());
    }
  }
}