import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class ProfileRepository {
  static ProfileRepository? _homeRepository;

  static ProfileRepository? getInstance() {
    _homeRepository ??= ProfileRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<ProfileErrorState, Profile>> getProfileData(String number) async {
    try {
      final trendingNews = await remoteDataSource.getProfileData(number);
      return Right(trendingNews);
    } on ServerException {
      return Left(ProfileErrorState(message: 'dumb'));
    } on Exception {
      return Left(ProfileErrorState(message: 'also dumb'));
    }
  }
}
