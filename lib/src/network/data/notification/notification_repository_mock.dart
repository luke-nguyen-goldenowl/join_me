import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/notification/upcoming_event.dart';
import 'package:myapp/src/network/model/user/user.dart';

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
        location: LatLng(11.2501, 107.4229),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        type: TypeEvent.sport,
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
        location: LatLng(11.2501, 107.4229),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        type: TypeEvent.sport,
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
        location: LatLng(11.2501, 107.4229),
        host: const MUser(
            id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
        type: TypeEvent.sport,
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
  MResult<MPaginationResponse<NotificationModel>> getNotifies(String userId) {
    final List<NotificationModel> notify = notifies;
    final result = MPaginationResponse(
      data: notify,
      meta: const MPaginationMeta(
        pageSize: MPagination.defaultPageLimit,
        totalCount: 50,
        pageNumber: 4,
        lastPage: 5,
      ),
    );
    return MResult.success(result);
  }
}
