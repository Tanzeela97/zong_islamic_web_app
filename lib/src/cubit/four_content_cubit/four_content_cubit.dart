import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'four_content_state.dart';

class FourContentCubit extends Cubit<FourContentState> {
  FourContentCubit() : super(FourContentInitial());
}
