import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/resource/repository/islamic_name_repository.dart';

part 'islamic_name_state.dart';

class IslamicNameCubit extends Cubit<IslamicNameState> {
  final IslamicNameRepository repository;

  IslamicNameCubit(this.repository) : super(IslamicNameInitial());

  void getIslamicName(String url,String? number) async {
    emit(const IslamicNameLoading());
    final Either<IslamicNameError, IslamicNameModel> eitherResponse =
        await repository.getIslamicName(url,number);
    emit(eitherResponse.fold(
        (failure) => IslamicNameError(message: failure.message),
        (data) => IslamicNameLoaded(islamicNameModel: data)));
  }
}
