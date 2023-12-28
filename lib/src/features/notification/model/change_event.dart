// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/notification/model/event.dart';

class ChangeEvent {
  String id;
  Event event;
  ChangeEvent({
    required this.id,
    required this.event,
  });
}
