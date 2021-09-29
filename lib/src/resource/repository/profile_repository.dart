import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class ProfileRepository {
  static ProfileRepository? _homeRepository;

  static ProfileRepository? getInstance() {
    _homeRepository ??= ProfileRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<MainMenuTrendingErrorState, Profile>> getProfileData() async {
    try {
      final trendingNews = await remoteDataSource.getProfileData();
      return Right(trendingNews);
    } on ServerException {
      return Left(MainMenuTrendingErrorState(message: 'dumb'));
    } on Exception {
      return Left(MainMenuTrendingErrorState(message: 'also dumb'));
    }
  }
}
