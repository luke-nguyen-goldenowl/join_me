// ignore_for_file: prefer_collection_literals

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressEvent extends StatelessWidget {
  const AddressEvent({
    super.key,
    required this.location,
    required this.onMapCreate,
  });

  final LatLng? location;
  final Function(GoogleMapController) onMapCreate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          if (location != null)
            SizedBox(
              height: 300,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    mapType: MapType.terrain,
                    onMapCreated: onMapCreate,
                    initialCameraPosition: CameraPosition(
                      target: location!,
                      zoom: 16,
                    ),
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer())),
                    markers: {
                      Marker(
                        markerId: const MarkerId('my location'),
                        position: location ?? const LatLng(0, 0),
                      )
                    },
                  )),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
