import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/models/event/event.dart';


class EventBloc extends Bloc<EventEvent, EventState> {
  int page = 1;

  final EventRepository eventRepository;
  EventBloc({required this.eventRepository}) : super(EventInitial()) {
    on<EventEvent>((event, emit) async {
      if (event is GetEvents) {
        if (state is EventLoading) return;

        final currentState = state;
        var oldEvents = <Event>[];

        if (currentState is EventSuccess) {
          oldEvents = currentState.events;
        }
        emit(EventLoading(isFirstFetch: true, events: oldEvents));

        try {
          await eventRepository
              .getEvent()
              .then((value) {
            // page++;
            // final newEvents = (state as EventLoading).events;
            // newEvents.addAll(value);

            var newEvents = <Event>[];
            newEvents = value;

            emit(EventSuccess(newEvents));
          });
        } catch (e) {
          emit(EventFailure(e.toString()));
        }
      } else if (event is ResetEvents) {
        emit(EventInitial());
        page = 1;

        emit(EventLoading( events:[], isFirstFetch: page == 1));
    
        try {
          await eventRepository
              .getEvent()
              .then((value) {
            // page++;
            // final newEvents = (state as EventLoading).events;
            // newEvents.addAll(value);

            var newEvents = <Event>[];
            newEvents = value;

            emit(EventSuccess(newEvents));
          });
        } on SocketException catch (_) {
          emit(EventFailure("No Network!"));
        } catch (e) {
          emit(EventFailure(e.toString()));
        }
      }
    });
  }
}
