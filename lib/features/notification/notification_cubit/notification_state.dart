part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  String message;
  NotificationState({required this.message});

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {
  NotificationInitial({required super.message});
}

class NotificationSuccess extends NotificationState {
  NotificationSuccess({required super.message});
}

class NotificationError extends NotificationState {
  NotificationError({required super.message});
}
