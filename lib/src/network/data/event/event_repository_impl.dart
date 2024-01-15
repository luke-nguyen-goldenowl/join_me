import 'package:myapp/src/network/data/event/event_reference.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
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

  Future<MResult<MPaginationResponse<MEvent>>> getEventsHostByUser(
      String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsHostByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsHostByUser(
    String userId,
  ) {
    return eventReference.getCountEventsHostByUser(userId);
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

  Future<MResult<MPaginationResponse<MEvent>>> getEventsUpcomingByUser(
      String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsUpcomingByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsUpcomingByUser(String userId) {
    return eventReference.getCountEventsUpcomingByUser(userId);
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsPastByUser(
      String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsPastByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsPastByUser(String userId) {
    return eventReference.getCountEventsPastByUser(userId);
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsFavoriteByUser(
      String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsFavoriteByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsFavoriteByUser(
    String userId,
  ) {
    return eventReference.getCountEventsFavoriteByUser(userId);
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsFollowedByUser(
      String userId,
      [MEvent? lastEvent]) async {
    return eventReference.getEventsFollowedByUser(userId, lastEvent);
  }

  Future<MResult<int>> getCountEventsFollowedByUser(
    String userId,
  ) {
    return eventReference.getCountEventsFollowedByUser(userId);
  }

  Future<MResult<List<MEvent>>> getEventsBySearch(String search, String userId,
      [MEvent? lastEvent]) {
    return eventReference.getEventsBySearch(search, userId);
  }

  Future<MResult<int>> getCountEventsBySearch(
    String search,
    String userId,
  ) async {
    return eventReference.getCountEventsBySearch(search, userId);
  }

  Future<MResult<MEvent>> updateEvent(MEvent event) {
    return eventReference.updateEvent(event);
  }

  Future<MResult<List<MEvent>>> getEventsByFilter(
      List<TypeEvent> types, DateTime firstDate, DateTime lastDate,
      [MEvent? lastEvent]) async {
    return eventReference.getEventsByFilter(
        types, firstDate, lastDate, lastEvent);
  }

  Future<MResult<int>> getCountEventsByFilter(
    List<TypeEvent> types,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    return eventReference.getCountEventsByFilter(types, firstDate, lastDate);
  }
}
