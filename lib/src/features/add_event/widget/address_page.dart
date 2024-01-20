import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/theme/colors.dart';
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
                                      current.isSearching,
                                  builder: (context, state) {
                                    return SearchBar(
                                      controller: context
                                          .read<AddEventBloc>()
                                          .textEditingController,
                                      leading: state.isSearching
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: XStateLoadingWidget())
                                          : const Icon(Icons.search),
                                      onChanged: context
                                          .read<AddEventBloc>()
                                          .setSearchAddress,
                                      onSubmitted: (value) {
                                        context
                                            .read<AddEventBloc>()
                                            .onSearchTextChanged(
                                                value, context);
                                      },
                                      trailing: [
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            context
                                                .read<AddEventBloc>()
                                                .textEditingController
                                                .clear();
                                            context
                                                .read<AddEventBloc>()
                                                .setSearchAddress("");
                                          },
                                        )
                                      ],
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
