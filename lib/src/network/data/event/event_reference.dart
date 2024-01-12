import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
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
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MEvent>> updateEvent(MEvent event) async {
    try {
      final MResult<MEvent> result = await set(event);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error("update event fail");
    } catch (e) {
      return MResult.exception(e);
    }
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
    String eventId,
    String userId,
    bool isFollowed,
  ) async {
    try {
      final result = await update(eventId, {
        'followersId': isFollowed
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId]),
        'countFollowers':
            isFollowed ? FieldValue.increment(-1) : FieldValue.increment(1),
      });
      if (result.isError == false) {
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFavoriteEvent(
    String eventId,
    String userId,
    bool isFavorite,
  ) async {
    try {
      final result = await update(eventId, {
        'favoritesId': isFavorite
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId]),
        'countFavorites':
            isFavorite ? FieldValue.increment(-1) : FieldValue.increment(1),
      });
      if (result.isError == false) {
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
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .orderBy('deadline')
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsHostByUser(String userId,
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
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MEvent>>> getEventsPopular(String userId) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .orderBy('deadline')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs
          .where((document) => document['host'] != userId)
          .toList()
          .map((e) => e.data())
          .toList();
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
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .where('deadline', isLessThan: oneWeekFromNow.toIso8601String())
          .orderBy('deadline')
          .orderBy('countFollowers', descending: true)
          .limit(15)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs
          .where((document) => document['host'] != userId)
          .toList()
          .map((e) => e.data())
          .toList();
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
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .orderBy('deadline')
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
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .orderBy('deadline')
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

  Future<MResult<List<MEvent>>> getEventsUpcomingByUser(String userId,
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
      return MResult.success(docs);
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
          .orderBy('deadline')
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

  Future<MResult<List<MEvent>>> getEventsPastByUser(String userId,
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
      return MResult.success(docs);
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
}
