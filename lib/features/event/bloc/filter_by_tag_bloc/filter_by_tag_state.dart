import 'package:equatable/equatable.dart';
import 'package:kese_events/models/event/event.dart';

class FilterByTagState extends Equatable {
  const FilterByTagState();

  @override
  List<Object> get props => [];
}

class FilterByTagInitial extends FilterByTagState {}

class FilterByTagLoading extends FilterByTagState {
  final List<Event> events;

  FilterByTagLoading({required this.events});
}

class FilterByTagSuccess extends FilterByTagState {
  final List<Event> events;
  FilterByTagSuccess([this.events = const []]);

  @override
  List<Object> get props => [events];
}

class FilterByTagFailure extends FilterByTagState {
  final String msg;

  FilterByTagFailure(this.msg);
}

// class FilterByTagNoNewData extends FilterByTagState {
//   String message = "";
//   List<Event> events = [];
//   FilterByTagNoNewData({required this.events, required this.message});
// }
