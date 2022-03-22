import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/quran_translation_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/list_category/list_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/cate_info.dart';
import 'package:zong_islamic_web_app/src/model/cate_info_list.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/quran_planner.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class QuranRepository {
  static QuranRepository? _homeRepository;

  static QuranRepository? getInstance() {
    _homeRepository ??= QuranRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<QuranErrorState, QuranPlanner>> insertQuranPlaner(
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
      return Left(QuranErrorState(message: ''));
    } on Exception {
      return Left(QuranErrorState(message: ''));
    }
  }

  Future<Either<QuranErrorState, QuranPlanner>> getQuranPlanner(
      String? number) async {
    try {
      final menuCategories = await remoteDataSource.getQuranPlanner(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(QuranErrorState(message: ''));
    } on Exception {
      return Left(QuranErrorState(message: ''));
    }
  }

  Future<Either<QuranErrorState, QuranPlanner>> updateQuranPlanner(
      String? number, String pageRead) async {
    try {
      final menuCategories = await remoteDataSource.updateQuranPlanner(
        number,
        pageRead,
      );
      return Right(menuCategories);
    } on ServerException {
      return Left(QuranErrorState(message: ''));
    } on Exception {
      return Left(QuranErrorState(message: ''));
    }
  }
}
