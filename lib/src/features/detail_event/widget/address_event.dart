import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressEvent extends StatelessWidget {
  const AddressEvent({
    super.key,
    required this.location,
  });

  final LatLng? location;

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
              color: AppColors.black,
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
                    onMapCreated: context.read<DetailEventBloc>().onMapCreate,
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
                        position: location!,
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
