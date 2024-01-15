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
            child: !context.watch<AddEventBloc>().state.isLoadingCurrentLocation
                ? Stack(
                    children: [
                      BlocBuilder<AddEventBloc, AddEventState>(
                          buildWhen: (previous, current) =>
                              previous.event.location != current.event.location,
                          builder: (context, state) {
                            return GoogleMap(
                              mapType: MapType.terrain,
                              onMapCreated:
                                  context.read<AddEventBloc>().onMapCreate,
                              initialCameraPosition: CameraPosition(
                                target: state.event.location ??
                                    const LatLng(10.790159, 106.6557574),
                                zoom: 16,
                              ),
                              onTap: (argument) {
                                context
                                    .read<AddEventBloc>()
                                    .handlePressMap(argument);
                              },
                              myLocationEnabled: true,
                              markers: {
                                Marker(
                                  markerId: const MarkerId('my location'),
                                  position: state.event.location!,
                                )
                              },
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchBar(
                            controller: context
                                .read<AddEventBloc>()
                                .textEditingController,
                            leading: const Icon(Icons.search),
                            onSubmitted: (value) {
                              context
                                  .read<AddEventBloc>()
                                  .onSearchTextChanged(value, context);
                            },
                            trailing: [
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  context
                                      .read<AddEventBloc>()
                                      .textEditingController
                                      .clear();
                                },
                              )
                            ]),
                      ),
                    ],
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
  }
}
