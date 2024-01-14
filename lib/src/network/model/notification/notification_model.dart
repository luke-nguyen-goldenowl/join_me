// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';

enum TypeNotify {
  followEvent,
  followUser,
  favoriteEvent,
  newEvent,
  changeEvent;

  static TypeNotify getTypeNotifyFromString(String typeNotifyString) {
    switch (typeNotifyString) {
      case 'changeEvent':
        return TypeNotify.changeEvent;
      case 'followEvent':
        return TypeNotify.followEvent;
      case 'followUser':
        return TypeNotify.followUser;
      case 'favoriteEvent':
        return TypeNotify.favoriteEvent;
      case 'newEvent':
        return TypeNotify.newEvent;
      default:
        return TypeNotify.changeEvent;
    }
  }

  static dynamic getModelNotify(Map<String, dynamic>? data, String type) {
    if (data == null) {
      return null;
    }
    switch (getTypeNotifyFromString(type)) {
      case TypeNotify.changeEvent:
        return MChangeEvent.fromMap(data);
      case TypeNotify.newEvent:
        return MChangeEvent.fromMap(data);
      case TypeNotify.followEvent:
        return MFollowEvent.fromMap(data);
      case TypeNotify.followUser:
        return MFollowUser.fromMap(data);
      case TypeNotify.favoriteEvent:
        return MFollowEvent.fromMap(data);
      default:
        return MFollowEvent.fromMap(data);
    }
  }
}

class NotificationModel {
  String? id;
  String hostId;
  TypeNotify type;
  dynamic data;
  DateTime? dateTime;
  NotificationModel({
    this.id,
    required this.hostId,
    required this.type,
    required this.data,
    this.dateTime,
  });

  NotificationModel copyWith({
    String? id,
    String? hostId,
    TypeNotify? type,
    dynamic data,
    DateTime? dateTime,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      hostId: hostId ?? this.hostId,
      type: type ?? this.type,
      data: data ?? this.data,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'hostId': hostId,
      'data': data.toMap(),
      'dateTime': DateTime.now().toIso8601String(),
      'isSeen': false
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
        id: id,
        hostId: map['hostId'],
        type: TypeNotify.getTypeNotifyFromString(map['type']),
        data: map['data'] != null
            ? TypeNotify.getModelNotify(
                map['data'] as Map<String, dynamic>, map['type'])
            : null,
        dateTime: DateTime.parse(map['dateTime']));
  }
}
