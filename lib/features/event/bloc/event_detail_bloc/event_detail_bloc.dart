
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_event.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRepository eventDetailRepository;

  EventDetailBloc({required this.eventDetailRepository}
  ) : super(EventDetailInitial()) {
    on<GetEventDetail>((event, emit) async {
      emit(EventDetailLoading());
      try {
        final evnt = await eventDetailRepository.getEventsById(event.id);
        print("eventtttttttttttttttttttttttttttttt");
        print(evnt.name);
        emit(EventDetailSuccess(evnt));
      } catch (e) {
        emit(EventDetailFailure(e.toString()));
      }
    });
  }
}
