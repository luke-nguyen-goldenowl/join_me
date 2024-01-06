import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

List<MEvent> listEvent = [
  MEvent(
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
  MEvent(
    id: '2',
    name: "Halloween",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    location: LatLng(11.2934, 107.4002),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    type: TypeEvent.music,
  ),
  MEvent(
    id: '3',
    name: "Sunday",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    location: LatLng(11.2896, 107.4428),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    type: TypeEvent.movie,
  ),
  MEvent(
    id: '4',
    name: "Merry",
    description: "this is description",
    images: ["assets/images/images/bg-event.jpg"],
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    location: LatLng(11.2313, 107.4389),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    type: TypeEvent.game,
  ),
];

class EventRepositoryMock {
  MResult<MEvent> getEvent(String id) {
    final MEvent result = MEvent(id: '1');
    return MResult.success(result);
  }

  MResult<List<MEvent>> getEventsSearch(String search) {
    if (search == "") return MResult.success([]);
    final result = listEvent
        .where((element) =>
            element.name?.toLowerCase().contains(search.toLowerCase()) ?? false)
        .toList();

    return MResult.success(result);
  }

  MResult<List<MEvent>> getAllEvent() {
    final List<MEvent> result = listEvent;
    return MResult.success(result);
  }

  MResult<MPaginationResponse<MEvent>> getEventsByUser(String userId) {
    final List<MEvent> events = listEvent;
    final result = MPaginationResponse(
      data: events,
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
