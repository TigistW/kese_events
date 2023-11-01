import 'package:equatable/equatable.dart';
import 'package:kese_events/models/event/event.dart';

class UpcomingEventState extends Equatable {
  const UpcomingEventState();

  @override
  List<Object> get props => [];
}

class UpcomingEventInitial extends UpcomingEventState {}

class UpcomingEventLoading extends UpcomingEventState {
  final List<Event> events;
  final bool isFirstFetch;

  UpcomingEventLoading({required this.events, this.isFirstFetch = false});
}

class UpcomingEventSuccess extends UpcomingEventState {
  final List<Event> events;
  UpcomingEventSuccess([this.events = const []]);

  @override
  List<Object> get props => [events];
}

class UpcomingEventFailure extends UpcomingEventState {
  final String msg;

  UpcomingEventFailure(this.msg);
}

class UpcomingEventNoNewData extends UpcomingEventState {
  String message = "";
  List<Event> events = [];
  UpcomingEventNoNewData({required this.events, required this.message});
}
