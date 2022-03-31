import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/salah_tracker_cubit/salah_tracker_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/salah_tracker.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class SalahTrackerRepository {
  static SalahTrackerRepository? _salahTrackerRepository;

  static SalahTrackerRepository? getInstance() {
    _salahTrackerRepository ??= SalahTrackerRepository();
    return _salahTrackerRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<SalahTrackerError, void>> postSalahTracker(String number,int fajar,int zohr,int asr,int magrib,int isha,String date) async {
    try {
      await remoteDataSource.postSalahTracker(number,fajar,zohr,asr,magrib,isha,date);
      return Right(Unit);
    } on ServerException {
      return Left(const SalahTrackerError());
    } on Exception {
      return Left(const SalahTrackerError());
    }
  }


  Future<Either<SalahTrackerError, List<SalahTracker>>> getSalahTracker(String number) async {
    try {
     final listOfSalah =  await remoteDataSource.getSalahTracker(number);
      return Right(listOfSalah);
    } on ServerException {
      return Left(const SalahTrackerError());
    } on Exception {
      return Left(const SalahTrackerError());
    }
  }



}
