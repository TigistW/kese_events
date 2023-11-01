import 'package:equatable/equatable.dart';

class FilterByTagEvent extends Equatable {
  const FilterByTagEvent();

  @override
  List<Object> get props => [];
}

class GetEventsByTags extends FilterByTagEvent {
  final int tag;
   GetEventsByTags(this.tag);

  @override
  List<Object> get props => [];
}

class ResetFlterByTags extends FilterByTagEvent {
  final int tag;
   ResetFlterByTags(this.tag);

  @override
  List<Object> get props => [];
}
