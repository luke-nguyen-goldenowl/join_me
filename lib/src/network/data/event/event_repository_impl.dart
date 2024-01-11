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
}
