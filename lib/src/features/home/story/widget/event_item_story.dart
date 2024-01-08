import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

// ignore: must_be_immutable
class EventItem extends StatelessWidget {
  EventItem({
    super.key,
    required this.event,
    required this.handlePress,
  });

  final MEvent event;
  void Function(MEvent) handlePress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handlePress(event);
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateHelper.getFullDateTime(date: event.startDate) ?? "",
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 15,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              event.name ?? "",
              style: const TextStyle(
                wordSpacing: 0,
                letterSpacing: 0,
                color: AppColors.black,
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.rosyPink.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "Follower: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                ),
                TextSpan(
                  text: event.followersId?.length.toString() ?? "",
                  style: const TextStyle(
                      color: AppColors.rosyPink,
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900),
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
