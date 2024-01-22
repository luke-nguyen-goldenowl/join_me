import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/forms/input.dart';
import 'package:myapp/widgets/state/state_loading_widget.dart';

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
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<AddEventBloc, AddEventState>(
              buildWhen: (previous, current) =>
                  previous.isLoadingCurrentLocation !=
                  current.isLoadingCurrentLocation,
              builder: (context, state) {
                return Expanded(
                  child: !state.isLoadingCurrentLocation
                      ? Stack(
                          children: [
                            BlocBuilder<AddEventBloc, AddEventState>(
                                buildWhen: (previous, current) =>
                                    previous.event.location !=
                                    current.event.location,
                                builder: (context, state) {
                                  return GoogleMap(
                                    mapType: MapType.terrain,
                                    onMapCreated: context
                                        .read<AddEventBloc>()
                                        .onMapCreate,
                                    initialCameraPosition: CameraPosition(
                                      target: state.event.location ??
                                          const LatLng(10.790159, 106.6557574),
                                      zoom: 16,
                                    ),
                                    onTap: context
                                        .read<AddEventBloc>()
                                        .handlePressMap,
                                    myLocationEnabled: true,
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId('my location'),
                                        position: state.event.location ??
                                            const LatLng(0, 0),
                                      )
                                    },
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<AddEventBloc, AddEventState>(
                                  buildWhen: (previous, current) =>
                                      previous.isSearching !=
                                          current.isSearching ||
                                      previous.searchAddress !=
                                          current.searchAddress,
                                  builder: (context, state) {
                                    return Align(
                                      alignment: Alignment.topCenter,
                                      child: XInput(
                                        value: state.searchAddress,
                                        onChanged: (value) {
                                          context
                                              .read<AddEventBloc>()
                                              .setSearchAddress(value);
                                        },
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                            hintText: "Search address",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            fillColor: AppColors.white,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 50.0,
                                              bottom: 8.0,
                                              top: 8.0,
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: state.isSearching
                                                  ? const SizedBox(
                                                      height: 10,
                                                      width: 10,
                                                      child:
                                                          XStateLoadingWidget())
                                                  : const Icon(Icons.search),
                                            )),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onFieldSubmitted: ((value) {
                                          context
                                              .read<AddEventBloc>()
                                              .onSearchTextChanged(
                                                  value, context);
                                        }),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.rosyPink,
                          ),
                        ),
                );
              }),
        ],
      ),
    );
  }
}
