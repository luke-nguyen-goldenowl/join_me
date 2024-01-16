import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/image/image_network.dart';

class EventSearchWidget extends StatelessWidget {
  const EventSearchWidget({super.key, required this.event});
  final MEvent event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppCoordinator.showEventDetails(id: event.id ?? "");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: XImageNetwork(
                event.images?[0],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    DateHelper.getFullDateTime(event.startDate),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
