import 'package:myapp/src/network/data/event/event_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class EventRepositoryImpl {
  final EventReference eventReference = EventReference();
  Future<MResult<MEvent>> addEvent(MEvent event) {
    return eventReference.addEvent(event);
  }

  Future<MResult<MEvent>> getEvent(String eventId) {
    return eventReference.getEvent(eventId);
  }
}
