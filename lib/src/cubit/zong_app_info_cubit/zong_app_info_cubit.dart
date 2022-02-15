import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/zong_app_info.dart';
import 'package:zong_islamic_web_app/src/resource/repository/zong_app_info_repository.dart';

part 'zong_app_info_state.dart';

class ZongAppInfoCubit extends Cubit<ZongAppInfoState> {
  final ZongAppInfoRepository _zongAppInfoRepository = ZongAppInfoRepository();
  ZongAppInfoCubit() : super(ZongAppInfoInitial());

  Future<void> getZongAppInfo() async{
    emit(ZongAppInfoLoading());
    final Either<ZongAppInfoError, ZongAppInformation> eitherResponse =
        await _zongAppInfoRepository.getZongAppInfo();
    emit(eitherResponse.fold(
          (l) => ZongAppInfoError(),
          (r) => ZongAppInfoLoaded(zongAppInformation: r),
    ));
  }
}
