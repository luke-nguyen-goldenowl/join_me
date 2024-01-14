import 'package:myapp/src/network/data/event/event_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class EventRepositoryImpl {
  final EventReference eventReference = EventReference();
  Future<MResult<MEvent>> addEvent(MEvent event) {
    return eventReference.addEvent(event);
  }

  Future<MResult> updateFollowEvent(
    MEvent event,
    MUser user,
    bool isFollowed,
  ) {
    return eventReference.updateFollowEvent(event, user, isFollowed);
  }

  Future<MResult> updateFavoriteEvent(
    MEvent event,
    MUser user,
    bool isFavorite,
  ) {
    return eventReference.updateFavoriteEvent(event, user, isFavorite);
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

  Future<MResult<List<MEvent>>> getEventsBySearch(String search, String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsBySearch(search, userId);
  }

  Future<MResult<int>> getCountEventsPastByUser(
    String search,
    String userId,
  ) async {
    return eventReference.getCountEventsBySearch(search, userId);
  }
}
