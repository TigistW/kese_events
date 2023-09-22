import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial(message: ""));
  void successNotification({required String message}) {
    emit(NotificationSuccess(message: message));
  }

  void errorNotification({required String message}) {
    emit(NotificationError(message: message));
  }

  void notificationInitital() {
    emit(NotificationInitial(message: ""));
  }
}
