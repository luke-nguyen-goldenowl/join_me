import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/services/firebase_storage.dart';

class EventReference extends BaseCollectionReference<MEvent> {
  EventReference()
      : super(
          FirebaseFirestore.instance.collection('events').withConverter<MEvent>(
                fromFirestore: (snapshot, options) => MEvent.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id!,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  final MFirebaseStorage firebaseStorage = MFirebaseStorage();

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
}
