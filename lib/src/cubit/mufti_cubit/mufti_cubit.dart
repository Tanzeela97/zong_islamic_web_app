import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/mufti.dart';
import 'package:zong_islamic_web_app/src/resource/repository/mufti_repositroy.dart';

part 'mufti_state.dart';

class MuftiCubit extends Cubit<MuftiState> {
  final  MuftiRepository _muftiRepository;
  MuftiCubit(this._muftiRepository) : super(MuftiInitialState());

  void getMufti({required String number})async{
    emit(const MuftiLoadingState());
    final eitherResponse = await _muftiRepository.getMufti(number);
    emit(eitherResponse.fold(
          (error) => MuftiErrorState(),
          (mufti) => MuftiSuccessState(mufti: mufti),
    ));
  }
}
