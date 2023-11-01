
import 'package:equatable/equatable.dart';

class EventDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEventDetail extends EventDetailEvent {
  final int id;
  GetEventDetail(
    this.id,
  );
}
