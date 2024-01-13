import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class EventItemEvent extends StatelessWidget {
  const EventItemEvent({
    super.key,
    required this.event,
  });
  final MEvent event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCoordinator.showEventDetails(id: event.id ?? "");
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(event.images?[0] ?? "").image,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderEvent(),
            _buildBottomEvent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomEvent() {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Starts at ${DateHelper.getTime(event.startDate)}",
            style: const TextStyle(fontSize: 15, color: AppColors.grey),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderEvent() {
    return Container(
      alignment: Alignment.center,
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            event.startDate?.day.toString() ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateHelper.getShortMonth(event.startDate),
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
