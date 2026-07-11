import '../data/dummy_events.dart';
import '../models/event_model.dart';

class EventService {
  List<EventModel> getTodaysEvents() {
    return dummyEvents.take(1).toList();
  }

  List<EventModel> getOtherEvents() {
    return dummyEvents.skip(1).toList();
  }

  List<EventModel> getRegisteredEvents() {
    return dummyEvents
        .where((event) => event.status == 'Registered')
        .toList();
  }

  EventModel getEventById(String id) {
    return dummyEvents.firstWhere(
      (event) => event.id == id,
    );
  }
}