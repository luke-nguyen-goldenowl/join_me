// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/event/event.dart';

class CategoryEvent {
  TypeEvent type;
  IconData get icon => type.icon;

  CategoryEvent({
    required this.type,
  });
}

List<CategoryEvent> categoryEvents = List.generate(TypeEvent.values.length,
    (index) => CategoryEvent(type: TypeEvent.values[index]));
