import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/services/firebase_storage.dart';
import 'package:myapp/src/services/image_picker.dart';

class AddEventBloc extends Cubit<AddEventState> {
  AddEventBloc({MEvent? event}) : super(AddEventState.ds(event));

  final DomainManager domain = DomainManager();
  PageController controller = PageController(initialPage: 0);
  GoogleMapController? mapController;
  TextEditingController textEditingController = TextEditingController();
  void onMapCreate(GoogleMapController controller) {
    mapController ??= controller;
  }

  void setCurrentPage(int index) {
    if (!isClosed) emit(state.copyWith(currentPage: index));
  }

  void selectMedias() async {
    int lengthEventImages = (state.event.images?.length ?? 0);
    List<XFile> pickMedias = await XImagePicker()
        .onPickMultiImage(limit: 5 - state.medias.length - lengthEventImages);
    if (!isClosed) {
      emit(state.copyWith(medias: [...pickMedias, ...state.medias]));
    }
  }

  void removeImage(int index) {
    if (state.medias.length - 1 < index) {
      return removeEventImages(index - state.medias.length);
    }

    final List<XFile?> newMedias = [...state.medias];
    newMedias.removeAt(index);
    if (!isClosed) emit(state.copyWith(medias: newMedias));
  }

  void removeEventImages(int index) {
    final List<String> newImages = [...state.event.images ?? []];
    newImages.removeAt(index);
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(images: newImages)));
    }
  }

  void handlePressMap(LatLng point) async {
    try {
      await _getAddressFromCoordinates(point);
      if (!isClosed) {
        emit(state.copyWith(event: state.event.copyWith(location: point)));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void setNameEvent(value) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(name: value)));
    }
  }

  void setDescriptionEvent(value) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(description: value)));
    }
  }

  void setNumberMemberEvent(value) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(maxAttendee: value)));
    }
  }

  void setStartDateEvent(value) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(startDate: value)));
    }
  }

  void setDeadlineEvent(value) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(deadline: value)));
    }
  }

  void setTimeEvent(value) {
    if (!isClosed) emit(state.copyWith(time: value));
  }

  void setType(TypeEvent type) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(type: type)));
    }
  }

  void setSearchAddress(String value) {
    if (!isClosed) {
      emit(state.copyWith(searchAddress: value));
    }
  }

  void editEvent() async {
    XToast.showLoading();

    List<String> listImage = [];
    if (state.medias.isNotEmpty) {
      final List<String> images = state.medias.map((e) => e!.path).toList();
      listImage = await XFirebaseStorage().uploadImages(images, "events");
    }

    DateTime? startDate;
    if (state.event.startDate != null && state.time != null) {
      startDate = DateTime(
        state.event.startDate!.year,
        state.event.startDate!.month,
        state.event.startDate!.day,
        state.time!.hour,
        state.time!.minute,
      );
    }
    final MEvent event = state.event.copyWith(
      images: [...listImage, ...state.event.images ?? []],
      startDate: startDate,
    );

    final result = await domain.event.updateEvent(event);

    XToast.hideLoading();

    if (result.isSuccess) {
      AppCoordinator.pop(result.data);
      XToast.success('Edit event success');
    } else {
      XAlert.show(title: 'Edit event fail', body: result.error);
    }
  }

  void addEvent() async {
    XToast.showLoading();

    late final List<String> images;

    images = state.medias.map((e) => e!.path).toList();

    DateTime? startDate;
    if (state.event.startDate != null && state.time != null) {
      startDate = DateTime(
        state.event.startDate!.year,
        state.event.startDate!.month,
        state.event.startDate!.day,
        state.time!.hour,
        state.time!.minute,
      );
    }
    final MEvent event = state.event.copyWith(
      images: images,
      startDate: startDate,
      host: GetIt.I<AccountBloc>().state.user,
      favoritesId: [],
      followersId: [],
    );

    final result = await domain.event.addEvent(event);

    XToast.hideLoading();

    AppCoordinator.pop();
    if (result.isSuccess) {
      XToast.success('Create event success');
    } else {
      XAlert.show(title: 'Create event fail', body: result.error);
    }
  }

  Future<void> getCurrentLocation() async {
    Position currentLocation;
    bool serviceEnabled;
    LocationPermission permission;
    try {
      if (state.event.location != null) {
        await _getAddressFromCoordinates(state.event.location!);
        return emit(
          state.copyWith(isLoadingCurrentLocation: false),
        );
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!isClosed) {
          emit(
            state.copyWith(isLoadingCurrentLocation: false),
          );
        }
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (!isClosed) {
            emit(
              state.copyWith(isLoadingCurrentLocation: false),
            );
          }
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!isClosed) {
          emit(
            state.copyWith(isLoadingCurrentLocation: false),
          );
        }
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      currentLocation = await Geolocator.getCurrentPosition();
      final LatLng locationLatLng = LatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      await _getAddressFromCoordinates(locationLatLng);
      if (!isClosed) {
        emit(
          state.copyWith(
              event: state.event.copyWith(location: locationLatLng),
              isLoadingCurrentLocation: false),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<LatLng?> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations =
          await locationFromAddress(address, localeIdentifier: 'vi_VN');
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return LatLng(location.latitude, location.longitude);
      }
    } catch (e) {
      print("Error getting coordinates: $e");
    }
    return null;
  }

  Future<void> _getAddressFromCoordinates(LatLng coordinates) async {
    try {
      if (!isClosed) emit(state.copyWith(isSearching: true));
      List<Placemark> addresses = await placemarkFromCoordinates(
          coordinates.latitude, coordinates.longitude,
          localeIdentifier: 'vi_VN');
      if (addresses.isNotEmpty) {
        String address =
            "${addresses.first.street}, ${addresses.first.subAdministrativeArea}, ${addresses.first.administrativeArea}, ${addresses.first.country}";
        textEditingController.text = address;
        setSearchAddress(address);
      }
    } catch (e) {
      print("Error getting coordinates: $e");
    }
    if (!isClosed) emit(state.copyWith(isSearching: false));
  }

  void onSearchTextChanged(String search, context) async {
    try {
      if (search.isEmpty) return;
      if (!isClosed) emit(state.copyWith(isSearching: true));
      LatLng? coordinates = await _getCoordinatesFromAddress(search);
      if (!isClosed) emit(state.copyWith(isSearching: false));
      if (coordinates != null) {
        handlePressMap(coordinates);
        await mapController?.moveCamera(
          CameraUpdate.newLatLngZoom(coordinates, 16),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Address not found"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    mapController?.dispose();
    textEditingController.dispose();
    controller.dispose();
    return super.close();
  }
}
