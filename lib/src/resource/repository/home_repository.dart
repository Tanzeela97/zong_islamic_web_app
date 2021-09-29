import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
 // final remoteDataSource = ZongIslamicRemoteDataSourceImpl(ApiClient(Client()));
  final ZongIslamicRemoteDataSourceImpl remoteDataSource;
  HomeRepository(this.remoteDataSource);

  Future<Either<MainMenuCategoryErrorState, List<MainMenuCategory>>>
      getComingSoon() async {
    try {
      final movies = await remoteDataSource.getMainMenuCategory();
      return Right(movies);
    } on ServerException {
      return Left(MainMenuCategoryErrorState(message: 'dumb'));
    } on Exception {
      return Left(MainMenuCategoryErrorState(message: 'also dumb'));
    }
  }
}
