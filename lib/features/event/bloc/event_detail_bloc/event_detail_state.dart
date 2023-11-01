
import 'package:equatable/equatable.dart';
import 'package:kese_events/models/event/event.dart';

class EventDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventDetailInitial extends EventDetailState {}

class EventDetailLoading extends EventDetailState {
  // final Event event;
  // EventDetailLoading(this.event);
}

class EventDetailSuccess extends EventDetailState {
  final Event event;
  EventDetailSuccess(
    this.event,
  );
}
class EventDetailFailure extends EventDetailState {
  final String msg;
  EventDetailFailure(
    this.msg,
  );
}
