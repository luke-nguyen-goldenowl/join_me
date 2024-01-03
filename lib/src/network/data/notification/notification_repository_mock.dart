import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/notification/upcoming_event.dart';
import 'package:myapp/src/network/model/user/user.dart';

enum TypeNotify { followEvent, followUser, upcomingEvent, changeEvent }

final List<NotificationModel> notifies = [
  NotificationModel(
    type: TypeNotify.changeEvent,
    data: MChangeEvent(
      id: '1',
      event: MEvent(
        id: '1',
        name: "Happy birthday",
        description: "this is description",
        images: ["assets/images/images/bg-event.jpg"],
        startDate: DateTime.now(),
        deadline: DateTime.now(),
        province: 'Ho Chi Minh',
        location: LatLng(88.00015, 85.1316546),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        follower: 122,
        type: 'sport',
      ),
    ),
  ),
  NotificationModel(
    type: TypeNotify.upcomingEvent,
    data: MUpcomingEvent(
      id: '1',
      event: MEvent(
        id: '1',
        name: "Happy birthday",
        description: "this is description",
        images: ["assets/images/images/bg-event.jpg"],
        startDate: DateTime.now(),
        deadline: DateTime.now(),
        province: 'Ho Chi Minh',
        location: LatLng(88.00015, 85.1316546),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        follower: 122,
        type: 'sport',
      ),
    ),
  ),
  NotificationModel(
    type: TypeNotify.followEvent,
    data: MFollowEvent(
      id: '1',
      event: MEvent(
        id: '1',
        name: "Happy birthday",
        description: "this is description",
        images: ["assets/images/images/bg-event.jpg"],
        startDate: DateTime.now(),
        deadline: DateTime.now(),
        province: 'Ho Chi Minh',
        location: LatLng(88.00015, 85.1316546),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        follower: 122,
        type: 'sport',
      ),
      user: const MUser(
          id: '2', name: 'NaNa', avatar: "assets/images/images/avatar.png"),
    ),
  ),
  NotificationModel(
    type: TypeNotify.followUser,
    data: MFollowUser(
      id: '3',
      user: const MUser(
          id: '2', name: 'NaNa', avatar: "assets/images/images/avatar.png"),
    ),
  )
];

class NotificationRepositoryMock {
  MResult<List<NotificationModel>> getNotifies(String userId) {
    final result = notifies;
    return MResult.success(result);
  }
}
