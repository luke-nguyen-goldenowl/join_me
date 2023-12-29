import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/network/model/user_event/user_event.dart';

class EventRepositoryMock {
  MResult<MEvent> getEvent(String id) {
    final MEvent result = MEvent.ds(id: '1', host: MUser.empty());
    return MResult.success(result);
  }

  MResult<MUserEvent> getEventsByUser(MUser user) {
    final MUserEvent result = MUserEvent(user: user, events: []);
    return MResult.success(result);
  }
}
