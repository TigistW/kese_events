import 'package:kese_events/features/event/dataprovider/event_dataprovider.dart';
import 'package:kese_events/models/event/event.dart';

class EventRepository {
  final EventDataProvider _eventDataProvider;
  
  EventRepository(
    this._eventDataProvider,
  );

  Future<List<Event>> getEvent() async {
    return _eventDataProvider.getEvents();
  }

    Future<List<Event>> getUpcomingEvent() async {
    return _eventDataProvider.getUpcomingEvents();
  }

  Future<Event> getEventsById(int id) async {
    return _eventDataProvider.getEventById(id);
  }

    Future<List<Event>> getEventsByTag(int tag)async {
    return _eventDataProvider.getEventByTag(tag);
  }
}
