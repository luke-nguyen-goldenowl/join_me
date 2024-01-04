import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
              height: 500,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                      center: location!,
                      zoom: 15,
                      onTap: ((tapPosition, point) {
                        print(location.toString());
                      })),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          rotate: true,
                          width: 30,
                          height: 30,
                          point: location!,
                          builder: (BuildContext context) {
                            return const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 50,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
