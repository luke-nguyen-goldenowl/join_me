import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/user/user.dart';

// Person(id: '1', image: 'assets/images/images/avatar.png', name: 'keith'),
// Person(id: '2', image: 'assets/images/images/avatar.png', name: 'jessica'),
// Person(id: '3', image: 'assets/images/images/avatar.png', name: 'Iron'),
// Person(id: '3', image: 'assets/images/images/avatar.png', name: 'Thor'),

List<MUser> users = [
  MUser(
    id: '1',
    avatar: 'assets/images/images/avatar.png',
    name: 'Keith',
  ),
  MUser(
    id: '1',
    avatar: 'assets/images/images/avatar.png',
    name: 'jessica',
  ),
  MUser(
    id: '1',
    avatar: 'assets/images/images/avatar.png',
    name: 'Iron',
  ),
  MUser(
    id: '1',
    avatar: 'assets/images/images/avatar.png',
    name: 'Thor',
  ),
];

class UserRepositoryMock {
  MResult<List<MUser>> getUsersSearch(String search) {
    if (search == "") return MResult.success([]);
    final result = users
        .where((element) =>
            element.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    return MResult.success(result);
  }
}
