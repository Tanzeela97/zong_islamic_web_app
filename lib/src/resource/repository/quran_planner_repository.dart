import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/quran_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/quran_planner.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class QuranPlannerRepository {
  static QuranPlannerRepository? _quranPlannerRepository;

  static QuranPlannerRepository? getInstance() {
    _quranPlannerRepository ??= QuranPlannerRepository();
    return _quranPlannerRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<QuranPlannerErrorState, QuranPlanner>> insertQuranPlaner(
      String? number,
      String counterQuran,
      String daysRead,
      String totalPage,
      String pageReadMints) async {
    try {
      final menuCategories = await remoteDataSource.insertQuranPlaner(
          number, counterQuran, daysRead, totalPage, pageReadMints);
      return Right(menuCategories);
    } on ServerException {
      return Left(QuranPlannerErrorState(message: ''));
    } on Exception {
      return Left(QuranPlannerErrorState(message: ''));
    }
  }

  Future<Either<QuranPlannerErrorState, QuranPlanner>> getQuranPlanner(
      {String? number}) async {
    try {
      final menuCategories = await remoteDataSource.getQuranPlanner(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(QuranPlannerErrorState(message: ''));
    } on Exception {
      return Left(QuranPlannerErrorState(message: ''));
    }
  }

  Future<Either<QuranPlannerErrorState, QuranPlanner>> updateQuranPlanner(
      String? number, String pageRead) async {
    try {
      final menuCategories = await remoteDataSource.updateQuranPlanner(
        number,
        pageRead,
      );
      return Right(menuCategories);
    } on ServerException {
      return Left(QuranPlannerErrorState(message: ''));
    } on Exception {
      return Left(QuranPlannerErrorState(message: ''));
    }
  }
}
