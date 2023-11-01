import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_event.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/models/event/event.dart';

class UpcomingEventBloc extends Bloc<UpcomingEventEvent, UpcomingEventState> {
  int page = 1;

  final EventRepository eventRepository;
  UpcomingEventBloc({required this.eventRepository}) : super(UpcomingEventInitial()) {
    on<UpcomingEventEvent>((event, emit) async {
      if (event is GetUpcomingEvents) {
        if (state is UpcomingEventLoading) return;

        final currentState = state;
        var oldEvents = <Event>[];

        if (currentState is UpcomingEventSuccess) {
          oldEvents = currentState.events;
        }
        emit(UpcomingEventLoading(isFirstFetch: true, events: oldEvents));

        try {
          await eventRepository.getUpcomingEvent().then((value) {
            // page++;
            // final newEvents = (state as UpcomingEventLoading).events;
            // newEvents.addAll(value);

            var newEvents = <Event>[];
            newEvents = value;


            emit(UpcomingEventSuccess(newEvents));
          });
        } catch (e) {
          print(e.toString());
          emit(UpcomingEventFailure(e.toString()));
        }
      } else if (event is ResetEvents) {
        emit(UpcomingEventInitial());
        page = 1;

        emit(UpcomingEventLoading(events: [], isFirstFetch: page == 1));

        try {
          await eventRepository.getEvent().then((value) {
            page++;
            final newEvents = (state as EventLoading).events;
            newEvents.addAll(value);
            emit(UpcomingEventSuccess(newEvents));
          });
        } on SocketException catch (_) {
          emit(UpcomingEventFailure("No Network!"));
        } catch (e) {
          emit(UpcomingEventFailure(e.toString()));
        }
      }
    });
  }
}
