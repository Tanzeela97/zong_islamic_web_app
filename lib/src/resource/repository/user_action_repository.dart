import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/user_action_cubit/user_action_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/user_action.dart';

import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class UserActionRepository {
  static UserActionRepository? _repository;

  static UserActionRepository? getInstance() {
    _repository ??= UserActionRepository();
    return _repository;
  }

  final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<UserActionError, UserAction>> setUserAction(
      {required String cate_id,
      required String cont_id,
      required String page,
      required String action,
      required String number}) async {
    try {
      final userAction = await _remoteDataSource.setUserAction(
          cate_id: cate_id,
          cont_id: cont_id,
          page: page,
          action: action,
          number: number);
      return Right(userAction);
    } on ServerException {
      return Left(UserActionError());
    } on Exception {
      return Left(UserActionError());
    }
  }
}
