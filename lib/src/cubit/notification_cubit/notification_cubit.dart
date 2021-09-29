import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository)
      : super(NotificationInitial());

  void getNotifications() async {
    emit(NotificationLoadingState());
    final Either<NotificationErrorState, List<Notification>> eitherResponse =
        (await _notificationRepository.getNotifications())
            as Either<NotificationErrorState, List<Notification>>;
    emit(eitherResponse.fold(
      (l) => NotificationErrorState(),
      (r) => NotificationSuccessState(notificationList: r),
    ));
  }
}
