import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_event.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/features/event/repository/tag_repository.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';

class TagBloc extends Bloc<TagEvent, TagState> {

  final TagRepository tagRepository;
  TagBloc({required this.tagRepository}) : super(TagInitial()) {
    
    on<TagEvent>((event, emit) async {

      if (event is GetTags) {
        if (state is TagLoading) return;
        final currentState = state;
        var oldTags = <Tag>[];
        if (currentState is TagSuccess) {
          oldTags = currentState.tags;
        }
        emit(TagLoading(tags: oldTags));
        try {
          await tagRepository.getTags().then((value) {
            var newTags = <Tag>[];
            newTags = value;
            emit(TagSuccess(newTags));
          });

        } catch (e) {
          emit(TagFailure(e.toString()));
        }
      } else if (event is ResetEvents) {
        emit(TagInitial());
        emit(TagLoading(tags: []));
        try {
          await tagRepository.getTags().then((value) {
           var newTags = <Tag>[];
            newTags = value;

            emit(TagSuccess(newTags));
          });
        } on SocketException catch (_) {
          emit(TagFailure("No Network!"));
        } catch (e) {
          emit(TagFailure(e.toString()));
        }
      }
    }
    );
  }
}
