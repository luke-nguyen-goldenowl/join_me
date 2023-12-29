import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/theme/colors.dart';

class EventLocation extends StatelessWidget {
  const EventLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 60,
          // padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.white,
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: AppColors.gradient),
              width: 3,
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Assets.images.images.bgEvent.image(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 80,
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
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "DJ Bobo final Blue tour this year in 2022",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
