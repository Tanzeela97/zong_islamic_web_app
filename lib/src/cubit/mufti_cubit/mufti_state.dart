part of 'mufti_cubit.dart';

@immutable
abstract class MuftiState {
  const MuftiState();
}

class MuftiInitialState extends MuftiState {
  const MuftiInitialState();
}
class MuftiLoadingState extends MuftiState {
  const MuftiLoadingState();
}
class MuftiSuccessState extends MuftiState {
  final Mufti mufti;
  const MuftiSuccessState({required this.mufti});
}
class MuftiErrorState extends MuftiState {
  const MuftiErrorState();
}

class QiratInitialState extends MuftiState {
  const QiratInitialState();
}
class QiratLoadingState extends MuftiState {
  const QiratLoadingState();
}
class QiratSuccessState extends MuftiState {
  final FileUpload fileUpload;
  const QiratSuccessState({required this.fileUpload});
}
class QiratErrorState extends MuftiState {
  const QiratErrorState();
}
