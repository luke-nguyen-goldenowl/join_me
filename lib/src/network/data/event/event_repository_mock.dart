import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

List<String> listImage = [
  'assets/images/images/landscape2.webp',
  'assets/images/images/landscape3.jpg',
  'assets/images/images/landscape4.webp',
  'assets/images/images/bg-event.jpg'
];

List<MEvent> events = [
  MEvent(
    id: '1',
    name: "Happy birthday",
    description: "this is description",
    images: listImage,
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(10.8231, 106.6297),
    host: const MUser(
        id: '1', name: 'Keith', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '2',
    name: "Halloween",
    description: "this is description",
    images: listImage,
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '3',
    name: "Sunday",
    description: "this is description",
    images: listImage,
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
  MEvent(
    id: '4',
    name: "Merry",
    description: "this is description",
    images: listImage,
    startDate: DateTime.now(),
    deadline: DateTime.now(),
    province: 'Ho Chi Minh',
    location: LatLng(88.00015, 85.1316546),
    host: const MUser(
        id: '2', name: 'Kien Vo', avatar: "assets/images/images/avatar.png"),
    follower: 122,
    type: 'sport',
  ),
];

class EventRepositoryMock {
  MResult<MEvent> getEvent(String id) {
    final MEvent result = events[0];
    return MResult.success(result);
  }

  MResult<List<MEvent>> getEventsSearch(String search) {
    if (search == "") return MResult.success([]);
    final result = events
        .where((element) =>
            element.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return MResult.success(result);
  }

  MResult<List<MEvent>> getEventsByUser(String userId) {
    final List<MEvent> result = events;
    return MResult.success(result);
  }
}
