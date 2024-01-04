import 'package:myapp/src/network/data/event/event_repository_impl.dart';
import 'package:myapp/src/network/data/event/event_repository_mock.dart';
import 'package:myapp/src/network/data/sign/sign_repository_impl.dart';
import 'package:myapp/src/network/data/story/story_repository_mock.dart';
import 'blob/data/upload_repository_impl.dart';
import 'data/user/user_repository_impl.dart';

class DomainManager {
  factory DomainManager() {
    _internal ??= DomainManager._();
    return _internal!;
  }
  DomainManager._();
  static DomainManager? _internal;

  final user = UserRepositoryImpl();
  final upload = UploadRepositoryImpl();
  final sign = SignRepositoryImpl();
  final story = StoryRepositoryMock();
  final eventMock = EventRepositoryMock();
  final event = EventRepositoryImpl();
}
