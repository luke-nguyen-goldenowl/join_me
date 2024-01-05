import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/theme/colors.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(builder: (context, state) {
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
            // Expanded(
            //   child:
            //   FlutterMap(
            //     mapController: context.read<AddEventBloc>().mapController,
            //     options: MapOptions(
            //       center: LatLng(10.790159, 106.6557574),
            //       zoom: 10.0,
            //       onTap: ((tapPosition, point) {
            //         context.read<AddEventBloc>().handleTap(point);
            //       }),
            //     ),
            //     children: [
            //       TileLayer(
            //         urlTemplate:
            //             'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //         userAgentPackageName: 'com.example.app',
            //       ),
            //       MarkerLayer(
            //         markers: [
            //           if (state.selectedLocation != null)
            //             Marker(
            //               rotate: true,
            //               width: 50.0,
            //               height: 50.0,
            //               point: state.selectedLocation!,
            //               builder: (BuildContext context) {
            //                 return const Icon(
            //                   Icons.location_pin,
            //                   color: Colors.red,
            //                   size: 50,
            //                 );
            //               },
            //             ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
