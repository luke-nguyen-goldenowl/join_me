// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/notification/model/event.dart';
import 'package:myapp/src/features/notification/model/user.dart';

class FollowEvent {
  String id;
  Event event;
  User user;
  FollowEvent({
    required this.id,
    required this.event,
    required this.user,
  });
}
