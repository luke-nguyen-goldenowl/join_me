import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddEventState {
  LatLng? selectedLocation;
  int currentPage;
  List<XFile?> medias;
  DateTime? startDate;
  DateTime? deadlineDate;
  TimeOfDay? time;
  String nameEvent;
  String description;
  int numberMember;

  AddEventState({
    required this.currentPage,
    required this.medias,
    required this.selectedLocation,
    required this.deadlineDate,
    required this.startDate,
    required this.time,
    required this.description,
    required this.nameEvent,
    required this.numberMember,
  });

  factory AddEventState.ds() {
    return AddEventState(
      currentPage: 0,
      medias: [],
      selectedLocation: null,
      time: null,
      deadlineDate: null,
      startDate: null,
      description: "",
      nameEvent: "",
      numberMember: 0,
    );
  }

  AddEventState copyWith({
    currentPage,
    medias,
    time,
    deadlineDate,
    startDate,
    selectedLocation,
    description,
    nameEvent,
    numberMember,
  }) {
    return AddEventState(
      currentPage: currentPage ?? this.currentPage,
      medias: medias ?? this.medias,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      time: time ?? this.time,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      nameEvent: nameEvent ?? this.nameEvent,
      numberMember: numberMember ?? this.numberMember,
    );
  }
}
