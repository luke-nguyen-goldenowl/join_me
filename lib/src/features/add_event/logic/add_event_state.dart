import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddEventState {
  PageController controller;
  MapController mapController;
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController numberMemberController;
  TextEditingController dateController;
  TextEditingController timeController;
  TextEditingController deadlineController;
  GlobalKey<FormState> formKey;
  LatLng? selectedLocation;
  int currentPage;
  List<XFile?> medias;
  DateTime? startDate;
  DateTime? deadlineDate;
  TimeOfDay? time;
  String nameEvent;
  String description;
  int numberMember;

  AddEventState(
      {required this.controller,
      required this.currentPage,
      required this.medias,
      required this.mapController,
      required this.selectedLocation,
      required this.dateController,
      required this.deadlineController,
      required this.timeController,
      required this.deadlineDate,
      required this.startDate,
      required this.time,
      required this.description,
      required this.nameEvent,
      required this.numberMember,
      required this.formKey,
      required this.descriptionController,
      required this.nameController,
      required this.numberMemberController});

  factory AddEventState.ds() {
    return AddEventState(
      controller: PageController(initialPage: 0),
      currentPage: 0,
      medias: [],
      mapController: MapController(),
      selectedLocation: null,
      dateController: TextEditingController(),
      timeController: TextEditingController(),
      deadlineController: TextEditingController(),
      nameController: TextEditingController(),
      descriptionController: TextEditingController(),
      numberMemberController: TextEditingController(),
      time: null,
      deadlineDate: null,
      startDate: null,
      description: "",
      nameEvent: "",
      numberMember: 0,
      formKey: GlobalKey<FormState>(),
    );
  }

  AddEventState copyWith({
    controller,
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
      controller: controller ?? this.controller,
      currentPage: currentPage ?? this.currentPage,
      medias: medias ?? this.medias,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      mapController: mapController,
      dateController: dateController,
      timeController: timeController,
      deadlineController: deadlineController,
      descriptionController: descriptionController,
      nameController: nameController,
      numberMemberController: numberMemberController,
      formKey: formKey,
      time: time ?? this.time,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      nameEvent: nameEvent ?? this.nameEvent,
      numberMember: numberMember ?? this.numberMember,
    );
  }
}
