import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_bloc.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressPageEditEvent extends StatelessWidget {
  const AddressPageEditEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEventBloc, EditEventState>(
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
                if (state.event.location != null)
                  Expanded(
                    child: FlutterMap(
                      mapController:
                          context.read<EditEventBloc>().mapController,
                      options: MapOptions(
                        // center: state.event.location!,
                        zoom: 13.0,
                        onTap: ((tapPosition, point) {
                          context.read<EditEventBloc>().handleTap(point);
                        }),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            // Marker(
                            //   rotate: true,
                            //   width: 50.0,
                            //   height: 50.0,
                            //   point: state.event.location!,
                            //   builder: (BuildContext context) {
                            //     return const Icon(
                            //       Icons.location_pin,
                            //       color: Colors.red,
                            //       size: 50,
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
