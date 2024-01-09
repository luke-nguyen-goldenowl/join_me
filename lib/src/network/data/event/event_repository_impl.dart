import 'package:myapp/src/network/data/event/event_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class EventRepositoryImpl {
  final EventReference eventReference = EventReference();
  Future<MResult<MEvent>> addEvent(MEvent event) {
    return eventReference.addEvent(event);
  }

  Future<MResult> updateFollowEvent(
    String eventId,
    String userId,
    bool isFollowed,
  ) {
    return eventReference.updateFollowEvent(eventId, userId, isFollowed);
  }

  Future<MResult> updateFavoriteEvent(
    String eventId,
    String userId,
    bool isFavorite,
  ) {
    return eventReference.updateFavoriteEvent(eventId, userId, isFavorite);
  }

  Future<MResult<MEvent>> getEvent(String eventId) {
    return eventReference.getEvent(eventId);
  }

  Future<MResult<List<MEvent>>> getEventsByUser(String userId) {
    return eventReference.getEventsByUser(userId);
  }

  Future<MResult<List<MEvent>>> getEventsPopular(String userId) {
    return eventReference.getEventsPopular(userId);
  }

  Future<MResult<List<MEvent>>> getEventsUpcoming(String userId) {
    return eventReference.getEventsUpcoming(userId);
  }

  Future<MResult<List<MEvent>>> getEventsPeople(List<String> people) {
    return eventReference.getEventsPeople(people);
  }

  Future<MResult<List<MEvent>>> getEventsFollow(String userId) {
    return eventReference.getEventsFollow(userId);
  }

  Future<MResult<List<MEvent>>> getEventsUpcomingByUser(String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsUpcomingByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsUpcomingByUser(String userId) {
    return eventReference.getCountEventsUpcomingByUser(userId);
  }
}
