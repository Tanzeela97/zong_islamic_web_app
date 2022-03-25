part of 'mufti_cubit.dart';

@immutable
abstract class MuftiState {
  const MuftiState();
}

class MuftiInitial extends MuftiState {
  const MuftiInitial();
}
class MuftiLoading extends MuftiState {
  const MuftiLoading();
}
class MuftiSuccess extends MuftiState {
  const MuftiSuccess();
}
class MuftiError extends MuftiState {
  const MuftiError();
}
