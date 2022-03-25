import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mufti_state.dart';

class MuftiCubit extends Cubit<MuftiState> {
  MuftiCubit() : super(MuftiInitial());
}
