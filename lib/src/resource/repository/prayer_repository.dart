import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/prayer_cubit/prayer_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class PrayerRepository {
  static PrayerRepository? _prayerRepository;

  static PrayerRepository? getInstance() {
    _prayerRepository ??= PrayerRepository();
    return _prayerRepository;
  }

  final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<PrayerErrorState, PrayerInfo>> getPrayerInfo() async {
    try {
      final prayerInfo = await _remoteDataSource.getPrayer();
      return Right(prayerInfo);
    } on ServerException {
      return const Left(PrayerErrorState(message: 'Something Went Wrong'));
    } on Exception {
      return const Left(PrayerErrorState(message: 'Something Went Wrong'));
    }
  }
}
