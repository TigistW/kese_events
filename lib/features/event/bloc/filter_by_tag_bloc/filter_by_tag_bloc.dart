import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_event.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_state.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_event.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/features/event/repository/tag_repository.dart';
import 'package:kese_events/models/event/event.dart';

class FilterByTagBloc extends Bloc<FilterByTagEvent, FilterByTagState> {
  final EventRepository eventRepository;
  FilterByTagBloc({required this.eventRepository}) : super(FilterByTagInitial()) {
    on<FilterByTagEvent>((event, emit) async {
      if (event is GetEventsByTags) {
        if (state is FilterByTagLoading) {
        return;
        };
        final currentState = state;
        
        var oldEvents = <Event>[];
        if (currentState is FilterByTagSuccess) {
          oldEvents = currentState.events;
        }
        emit(FilterByTagLoading(events: oldEvents));
        try {
          await eventRepository.getEventsByTag(event.tag).then((value) {
            var newEvents = <Event>[];
            newEvents = value;
            emit(FilterByTagSuccess(newEvents));
          });
        } catch (e) {
          print("llllllllllllllllllll");
          print(e.toString());
          emit(FilterByTagFailure(e.toString()));
        }
      } else if (event is ResetEvents) {
        emit(FilterByTagInitial());
        emit(FilterByTagLoading(events: []));
        try {
          await eventRepository.getEventsByTag(2).then((value) {
            var newEvents = <Event>[];
            newEvents = value;

            emit(FilterByTagSuccess(newEvents));
          });
        } on SocketException catch (_) {
          emit(FilterByTagFailure("No Network!"));
        } catch (e) {
          emit(FilterByTagFailure(e.toString()));
        }
      }
    });
  }
}
