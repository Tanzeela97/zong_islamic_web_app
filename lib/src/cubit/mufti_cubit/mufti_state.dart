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
