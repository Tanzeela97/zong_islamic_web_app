import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/salah_tracker_cubit/salah_tracker_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class SalahTrackerRepository {
  static SalahTrackerRepository? _salahTrackerRepository;

  static SalahTrackerRepository? getInstance() {
    _salahTrackerRepository ??= SalahTrackerRepository();
    return _salahTrackerRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<SalahTrackerError, void>> postSalahTracker(String number) async {
    try {
      await remoteDataSource.postSalahTracker(number);
      return Right(None());
    } on ServerException {
      return Left(const SalahTrackerError());
    } on Exception {
      return Left(const SalahTrackerError());
    }
  }
}
