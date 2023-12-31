import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/theme/colors.dart';

class EventLocation extends StatelessWidget {
  const EventLocation(
      {super.key,
      required this.myIndex,
      required this.currentEvent,
      required this.handleSetNewEvent});
  final int myIndex;
  final int currentEvent;
  final Function(int myIndex) handleSetNewEvent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.white,
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: AppColors.gradient),
              width: 3,
            ),
          ),
          child: InkWell(
            onTap: () {
              handleSetNewEvent(myIndex);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Assets.images.images.bgEvent.image(
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (myIndex == currentEvent)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Assets.images.images.bgEvent.image(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "DJ Bobo final Blue tour this year in 2022",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
