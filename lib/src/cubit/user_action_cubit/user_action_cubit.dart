import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/user_action.dart';
import 'package:zong_islamic_web_app/src/resource/repository/user_action_repository.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  final UserActionRepository _userActionRepository = UserActionRepository();

  UserActionCubit() : super(UserActionInitial());

  Future<void> setUserAction(
      {required String cate_id,
      required String cont_id,
      required String page,
      required String action}) async {
    final Either<UserActionError, UserAction> eitherResponse =
        await _userActionRepository.setUserAction(cate_id: cate_id, cont_id: cont_id, page: page, action: action);
    emit(eitherResponse.fold((l) => const UserActionError(),
        (r) => UserActionLoaded(userAction: r)));
  }
}
