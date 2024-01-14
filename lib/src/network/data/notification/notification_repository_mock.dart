// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
// import 'package:myapp/src/network/model/common/pagination/pagination.dart';
// import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
// import 'package:myapp/src/network/model/common/result.dart';
// import 'package:myapp/src/network/model/event/event.dart';
// import 'package:myapp/src/network/model/notification/change_event.dart';
// import 'package:myapp/src/network/model/notification/follow_event.dart';
// import 'package:myapp/src/network/model/notification/follow_user.dart';
// import 'package:myapp/src/network/model/notification/notification_model.dart';
// import 'package:myapp/src/network/model/user/user.dart';

// final List<NotificationModel> notifies = [
//   NotificationModel(
//     id: '1',
//     hostId: "1",
//     type: TypeNotify.changeEvent,
//     data: MChangeEvent(
//       event: MEvent(
//         id: '1',
//         name: "Happy birthday",
//         description: "this is description",
//         images: ["assets/images/images/bg-event.jpg"],
//         startDate: DateTime.now(),
//         deadline: DateTime.now(),
//         location: const LatLng(11.2501, 107.4229),
//         host: MUser(
//             id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
//         type: TypeEvent.sport,
//       ),
//     ),
//     dateTime: DateTime.now(),
//   ),
//   NotificationModel(
//     id: '1',
//     hostId: "1",
//     type: TypeNotify.followEvent,
//     data: MFollowEvent(
//       event: MEvent(
//         id: '1',
//         name: "Happy birthday",
//         description: "this is description",
//         images: ["assets/images/images/bg-event.jpg"],
//         startDate: DateTime.now(),
//         deadline: DateTime.now(),
//         location: const LatLng(11.2501, 107.4229),
//         host: MUser(
//             id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
//         type: TypeEvent.sport,
//       ),
//       user: MUser(
//           id: '2', name: 'NaNa', avatar: "assets/images/images/avatar.png"),
//     ),
//     dateTime: DateTime.now(),
//   ),
//   NotificationModel(
//     id: '1',
//     hostId: "1",
//     type: TypeNotify.followUser,
//     data: MFollowUser(
//       host: MUser(
//           id: '2', name: 'NaNa', avatar: "assets/images/images/avatar.png"),
//       follower: MUser(
//           id: '2', name: 'NaNa', avatar: "assets/images/images/avatar.png"),
//     ),
//     dateTime: DateTime.now(),
//   )
// ];

// class NotificationRepositoryMock {
//   MResult<MPaginationResponse<NotificationModel>> getNotifies(String userId) {
//     final List<NotificationModel> notify = notifies;
//     final result = MPaginationResponse(
//       data: notify,
//       meta: const MPaginationMeta(
//         pageSize: MPagination.defaultPageLimit,
//         totalCount: 50,
//         pageNumber: 4,
//         lastPage: 5,
//       ),
//     );
//     return MResult.success(result);
//   }
// }
