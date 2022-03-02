import 'dart:io';

import 'package:zong_islamic_web_app/src/cubit/all_recording_cubit/all_recording_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/otp/otp_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/qirat_post_cubit/qirat_post_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AllRecordingRepository {
  static AllRecordingRepository? _authRepository;

  static AllRecordingRepository? getInstance() {
    _authRepository ??= AllRecordingRepository();
    return _authRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<AllRecordingErrorState, String>> getAllRecording(
      String number) async {
    try {
      final menuCategories = await remoteDataSource.getAllRecording(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(AllRecordingErrorState(message: ''));
    } on Exception {
      return Left(AllRecordingErrorState(message: ''));
    }
  }

  Future<Either<QiratPostErrorState, String>> postQirat(String filePath) async {
    try {
      final menuCategories = await remoteDataSource.postQirat(filePath);
      return Right(menuCategories);
    } on ServerException {
      return Left(QiratPostErrorState(message: ''));
    } on Exception {
      return Left(QiratPostErrorState(message: ''));
    }
  }
}
