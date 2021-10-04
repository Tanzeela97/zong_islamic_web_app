import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginInitial());

  void getLogin() async {
    emit(LoginLoadingState());
    final Either<LoginErrorState, String> eitherResponse =
    (await authRepository.login());
    emit(eitherResponse.fold(
          (l) => LoginErrorState(message: 'Something Went Wrong'),
          (r) => LoginSuccessState(string: r),
    ));
  }
}
