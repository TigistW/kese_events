import 'package:equatable/equatable.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';

class TagState extends Equatable {
  const TagState();

  @override
  List<Object> get props => [];
}

class TagInitial extends TagState {}

class TagLoading extends TagState {
  final List<Tag> tags;

  TagLoading({required this.tags});
}

class TagSuccess extends TagState {
  final List<Tag> tags;
  TagSuccess([this.tags = const []]);

  @override
  List<Object> get props => [tags];
}

class TagFailure extends TagState {
  final String msg;

  TagFailure(this.msg);
}

// class TagNoNewData extends TagState {
//   String message = "";
//   List<Tag> tags = [];
//   TagNoNewData({required this.tags, required this.message});
// }
