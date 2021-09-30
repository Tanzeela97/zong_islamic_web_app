import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  static AuthRepository? _authRepository;

  static AuthRepository? getInstance() {
    _authRepository ??= AuthRepository();
    return _authRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<NotificationErrorState, String>> login() async {
    try {
      final menuCategories = await remoteDataSource.login();
      return Right(menuCategories);
    } on ServerException {
      return Left(NotificationErrorState(message: 'dumb'));
    } on Exception {
      return Left(NotificationErrorState(message: 'also dumb'));
    }
  }

  Future<Either<NotificationErrorState, String>> verifyOtp(
      String number, String code) async {
    try {
      final menuCategories = await remoteDataSource.verifyOtp(number, code);
      return Right(menuCategories);
    } on ServerException {
      return Left(NotificationErrorState(message: 'dumb'));
    } on Exception {
      return Left(NotificationErrorState(message: 'also dumb'));
    }
  }
}
