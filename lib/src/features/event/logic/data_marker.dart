// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataMarker {
  String id;
  GlobalKey globalKey;
  LatLng position;
  Widget widget;
  String title;
  String snippet;
  DataMarker({
    required this.id,
    required this.globalKey,
    required this.position,
    required this.widget,
    required this.title,
    required this.snippet,
  });

  DataMarker copyWith({
    String? id,
    GlobalKey? globalKey,
    LatLng? position,
    Widget? widget,
    String? title,
    String? snippet,
  }) {
    return DataMarker(
      id: id ?? this.id,
      globalKey: globalKey ?? this.globalKey,
      position: position ?? this.position,
      widget: widget ?? this.widget,
      title: title ?? this.title,
      snippet: snippet ?? this.snippet,
    );
  }
}
