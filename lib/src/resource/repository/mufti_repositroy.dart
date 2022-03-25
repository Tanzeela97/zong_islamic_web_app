import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/mufti_cubit/mufti_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/quran_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/mufti.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class MuftiRepository{
  static MuftiRepository? _muftiRepository;

  static MuftiRepository? getInstance() {
    _muftiRepository ??= MuftiRepository();
    return _muftiRepository;
  }
  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<MuftiErrorState, Mufti>> getMufti(String number) async {
    try {
      final menuCategories = await remoteDataSource.getMufti(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(const MuftiErrorState());
    } on Exception {
      return Left(const MuftiErrorState());
    }
  }

}