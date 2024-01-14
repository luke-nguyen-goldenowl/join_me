// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/network/model/notification/upcoming_event.dart';

enum TypeNotify {
  followEvent,
  followUser,
  upcomingEvent,
  changeEvent;

  static TypeNotify getTypeNotifyFromString(String typeNotifyString) {
    switch (typeNotifyString) {
      case 'changeEvent':
        return TypeNotify.changeEvent;
      case 'followEvent':
        return TypeNotify.followEvent;
      case 'followUser':
        return TypeNotify.followUser;
      case 'upcomingEvent':
        return TypeNotify.upcomingEvent;
      default:
        return TypeNotify.changeEvent;
    }
  }

  static dynamic getModelNotify(dynamic data, String type) {
    switch (getTypeNotifyFromString(type)) {
      case TypeNotify.changeEvent:
        return MChangeEvent.fromMap(data);
      case TypeNotify.followEvent:
        return MFollowEvent.fromMap(data);
      case TypeNotify.followUser:
        return MFollowUser.fromMap(data);
      case TypeNotify.upcomingEvent:
        return MUpcomingEvent.fromMap(data);
      default:
        return MFollowEvent.fromMap(data);
    }
  }
}

class NotificationModel {
  String? id;
  TypeNotify type;
  dynamic data;
  DateTime? dateTime;
  NotificationModel({
    this.id,
    required this.type,
    required this.data,
    this.dateTime,
  });

  NotificationModel copyWith({
    String? id,
    TypeNotify? type,
    dynamic data,
    DateTime? dateTime,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      data: data ?? this.data,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'data': data.toMap(),
      'dateTime': DateTime.now().toIso8601String(),
      'isSeen': false
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
        id: id,
        type: TypeNotify.getTypeNotifyFromString(map['type']),
        data: TypeNotify.getModelNotify(map['data'], map['type']),
        dateTime: DateTime.parse(map['dateTime']));
  }
}
