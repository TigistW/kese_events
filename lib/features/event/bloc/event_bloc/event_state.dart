import 'package:equatable/equatable.dart';
import 'package:kese_events/models/event/event.dart';

class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {
  final List<Event> events;
  final bool isFirstFetch;

  EventLoading({
  required this.events, 
  this.isFirstFetch = false});
}

class EventSuccess extends EventState {
  final List<Event> events;
  EventSuccess([this.events = const []]);

  @override
  List<Object> get props => [events];
}

class EventFailure extends EventState {
  final String msg;

  EventFailure(this.msg);
}


class EventNoNewData extends EventState {
  String message = "";
  List<Event> events = [];
  EventNoNewData({required this.events, required this.message});
}
