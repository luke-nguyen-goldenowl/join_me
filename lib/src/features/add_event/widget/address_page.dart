import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
        buildWhen: (previous, current) =>
            previous.event.location != current.event.location,
        builder: (context, state) {
          return Container(
            color: AppColors.white,
            child: Column(
              children: [
                const Text(
                  "Select location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: !state.isLoadingCurrentLocation
                      ? GoogleMap(
                          mapType: MapType.terrain,
                          onMapCreated:
                              context.read<AddEventBloc>().onMapCreate,
                          initialCameraPosition: CameraPosition(
                            target: state.event.location!,
                            zoom: 16,
                          ),
                          onTap: (argument) {
                            context
                                .read<AddEventBloc>()
                                .handlePressMap(argument);
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId('my location'),
                              position: state.event.location!,
                            )
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.rosyPink,
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
