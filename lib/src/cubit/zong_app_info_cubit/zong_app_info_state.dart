part of 'zong_app_info_cubit.dart';

@immutable
abstract class ZongAppInfoState {
  const ZongAppInfoState();
}

class ZongAppInfoInitial extends ZongAppInfoState {
  const ZongAppInfoInitial();
}
class ZongAppInfoLoading extends ZongAppInfoState {
  const  ZongAppInfoLoading();
}
class ZongAppInfoLoaded extends ZongAppInfoState {
  final ZongAppInformation zongAppInformation;
  const ZongAppInfoLoaded({required this.zongAppInformation});
}
class ZongAppInfoError extends ZongAppInfoState {
  const ZongAppInfoError();
}
