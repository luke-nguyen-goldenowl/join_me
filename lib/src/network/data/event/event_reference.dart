import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/services/firebase_storage.dart';

class EventReference extends BaseCollectionReference<MEvent> {
  EventReference()
      : super(
          FirebaseFirestore.instance.collection('events').withConverter<MEvent>(
                fromFirestore: (snapshot, options) => MEvent.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id ?? "",
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  final XFirebaseStorage firebaseStorage = XFirebaseStorage();

  Future<MResult<MEvent>> addEvent(MEvent event) async {
    try {
      final listImage =
          await firebaseStorage.uploadImages(event.images ?? [], "events");
      MEvent newEvent = event.copyWith(images: listImage);
      final MResult<MEvent> result = await add(newEvent);
      if (result.isSuccess) {
        await DomainManager()
            .notification
            .sendNotificationNewEvent(result.data!);
        return MResult.success(result.data);
      }
      return MResult.error('Add event fail');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MEvent>> updateEvent(MEvent event) async {
    return await set(event);
  }

  Future<MResult<MEvent>> getEvent(String eventId) async {
    try {
      UserReference userReference = UserReference();
      final MResult<MEvent> eventResult = await get(eventId);
      if (eventResult.isSuccess) {
        final MResult<MUser> user =
            await userReference.getUser(eventResult.data!.host?.id ?? "");
        if (user.isSuccess) {
          final MEvent event = eventResult.data!.copyWith(host: user.data);
          return MResult.success(event);
        } else {
          return MResult.error('host not found');
        }
      } else {
        return MResult.error('Event not found');
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MEvent>> getEventNoUser(String eventId) async {
    try {
      final MResult<MEvent> eventResult = await get(eventId);
      if (eventResult.isSuccess) {
        return MResult.success(eventResult.data);
      } else {
        return MResult.error('Event not found');
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFollowEvent(
    MEvent event,
    MUser user,
    bool isFollowed,
  ) async {
    try {
      final result = await update(event.id, {
        'followersId': isFollowed
            ? FieldValue.arrayRemove([user.id])
            : FieldValue.arrayUnion([user.id]),
        'countFollowers':
            isFollowed ? FieldValue.increment(-1) : FieldValue.increment(1),
      });
      if (result.isError == false) {
        if (!isFollowed) {
          await DomainManager()
              .notification
              .sendNotificationFollowEvent(event, user);
        }
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFavoriteEvent(
    MEvent event,
    MUser user,
    bool isFavorite,
  ) async {
    try {
      final result = await update(event.id, {
        'favoritesId': isFavorite
            ? FieldValue.arrayRemove([user.id])
            : FieldValue.arrayUnion([user.id]),
        'countFavorites':
            isFavorite ? FieldValue.increment(-1) : FieldValue.increment(1),
      });
      if (result.isError == false) {
        if (!isFavorite) {
          await DomainManager()
              .notification
              .sendNotificationFavoriteEvent(event, user);
        }
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsByUser(String userId) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('host', isEqualTo: userId)
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsHostByUser(
      String userId,
      [MEvent? lastEvent]) async {
    try {
      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('host', isEqualTo: userId)
          .orderBy('startDate')
          .orderBy('deadline')
          .startAfter(lastEvent != null
              ? [
                  lastEvent.startDate?.toIso8601String(),
                  lastEvent.deadline?.toIso8601String()
                ]
              : [0])
          .limit(MPagination.defaultPageLimit)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      final paginationResponse = MPaginationResponse<MEvent>(data: docs);
      return MResult.success(paginationResponse);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsPopular(String userId) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      docs.sort((a, b) =>
          (b.followersId?.length ?? 0).compareTo(a.followersId?.length ?? 0));
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsUpcoming(String userId) async {
    try {
      DateTime currentDate = DateTime.now();
      DateTime oneWeekFromNow = currentDate.add(const Duration(days: 7));

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .where('startDate', isLessThan: oneWeekFromNow.toIso8601String())
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final List<MEvent> docs =
          querySnapshot.docs.map((e) => e.data()).toList();
      docs.sort((a, b) =>
          (b.followersId?.length ?? 0).compareTo(a.followersId?.length ?? 0));
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsPeople(List<String> people) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('host', whereIn: people)
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsFollow(String userId) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsUpcomingByUser(
      String userId,
      [MEvent? lastEvent]) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('host')
          .startAfter(lastEvent != null
              ? [lastEvent.startDate?.toIso8601String(), lastEvent.host?.id]
              : [0])
          .limit(MPagination.defaultPageLimit)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      final paginationResponse = MPaginationResponse<MEvent>(data: docs);
      return MResult.success(paginationResponse);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsHostByUser(
    String userId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('host', isEqualTo: userId)
          .orderBy('startDate')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsUpcomingByUser(
    String userId,
  ) async {
    try {
      DateTime currentDate = DateTime.now();

      final AggregateQuerySnapshot querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .where('startDate', isGreaterThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('host')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsPastByUser(
      String userId,
      [MEvent? lastEvent]) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .where('startDate', isLessThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('host')
          .startAfter(lastEvent != null
              ? [lastEvent.startDate?.toIso8601String(), lastEvent.host?.id]
              : [0])
          .limit(MPagination.defaultPageLimit)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      final paginationResponse = MPaginationResponse<MEvent>(data: docs);
      return MResult.success(paginationResponse);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsPastByUser(
    String userId,
  ) async {
    try {
      DateTime currentDate = DateTime.now();

      final AggregateQuerySnapshot querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .where('startDate', isLessThan: currentDate.toIso8601String())
          .orderBy('startDate')
          .orderBy('host')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsFavoriteByUser(
      String userId,
      [MEvent? lastEvent]) async {
    try {
      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('favoritesId', arrayContains: userId)
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .startAfter(lastEvent != null
              ? [
                  lastEvent.startDate?.toIso8601String(),
                  lastEvent.followersId?.length
                ]
              : [0])
          .limit(MPagination.defaultPageLimit)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      final paginationResponse = MPaginationResponse<MEvent>(data: docs);
      return MResult.success(paginationResponse);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsBySearch(String search, String userId,
      [MEvent? lastEvent]) async {
    try {
      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('host', isNotEqualTo: userId)
          .where('caseSearchName', arrayContains: search)
          .orderBy('host')
          .orderBy('startDate')
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsBySearch(
    String search,
    String userId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('host', isNotEqualTo: userId)
          .where('caseSearchName', arrayContains: search)
          .orderBy('host')
          .orderBy('startDate')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsFavoriteByUser(
    String userId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('favoritesId', arrayContains: userId)
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MPaginationResponse<MEvent>>> getEventsFollowedByUser(
      String userId,
      [MEvent? lastEvent]) async {
    try {
      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .startAfter(lastEvent != null
              ? [
                  lastEvent.startDate?.toIso8601String(),
                  lastEvent.host?.followers?.length
                ]
              : [0])
          .limit(MPagination.defaultPageLimit)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      final paginationResponse = MPaginationResponse<MEvent>(data: docs);
      return MResult.success(paginationResponse);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  List<String> _typesToString(List<TypeEvent> types) {
    if (types.isEmpty) {
      return TypeEvent.values.map((e) => e.name).toList();
    }

    return types.map((e) => e.name).toList();
  }

  Future<MResult<List<MEvent>>> getEventsByFilter(
      List<TypeEvent> types, DateTime firstDate, DateTime lastDate,
      [MEvent? lastEvent]) async {
    try {
      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('startDate', isGreaterThan: firstDate.toIso8601String())
          .where('startDate', isLessThan: lastDate.toIso8601String())
          .where('type', whereIn: _typesToString(types))
          .orderBy('startDate')
          .orderBy('host')
          .startAfter(lastEvent != null
              ? [lastEvent.startDate?.toIso8601String(), lastEvent.host?.id]
              : [0])
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsFollowedByUser(
    String userId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('followersId', arrayContains: userId)
          .orderBy('startDate')
          .orderBy('countFollowers', descending: true)
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountEventsByFilter(
    List<TypeEvent> types,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('startDate', isGreaterThan: firstDate.toIso8601String())
          .where('startDate', isLessThan: lastDate.toIso8601String())
          .where('type', whereIn: _typesToString(types))
          .orderBy('startDate')
          .orderBy('host')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
