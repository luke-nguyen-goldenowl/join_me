import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/user/user.dart';

List<MUser> listUser = [
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
    final result = listUser
        .where((element) =>
            element.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    return MResult.success(result);
  }

  MResult<MPaginationResponse<MUser>> getFavoriteListByUser(String userId) {
    final List<MUser> users = listUser;
    final result = MPaginationResponse(
      data: users,
    );
    return MResult.success(result);
  }
}
