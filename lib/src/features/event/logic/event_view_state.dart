// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:myapp/src/network/model/event/event.dart';

enum TypeShow { map, list }

class EventViewState {
  DateTime? firstDate;
  DateTime? lastDate;
  List<DateTime> weekDays;
  List<TypeEvent> types;
  TypeShow typeShow;
  EventViewState({
    this.firstDate,
    this.lastDate,
    this.typeShow = TypeShow.list,
    required this.weekDays,
    required this.types,
  });

  factory EventViewState.ds() {
    return EventViewState(weekDays: [], types: []);
  }

  EventViewState copyWith({
    DateTime? firstDate,
    DateTime? lastDate,
    List<DateTime>? weekDays,
    List<TypeEvent>? types,
    TypeShow? typeShow,
  }) {
    return EventViewState(
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate ?? this.lastDate,
      weekDays: weekDays ?? this.weekDays,
      types: types ?? this.types,
      typeShow: typeShow ?? this.typeShow,
    );
  }

  @override
  bool operator ==(covariant EventViewState other) {
    if (identical(this, other)) return true;

    return other.firstDate == firstDate &&
        other.lastDate == lastDate &&
        listEquals(other.weekDays, weekDays) &&
        listEquals(other.types, types) &&
        other.typeShow == typeShow;
  }

  @override
  int get hashCode {
    return firstDate.hashCode ^
        lastDate.hashCode ^
        weekDays.hashCode ^
        types.hashCode ^
        typeShow.hashCode;
  }
}
