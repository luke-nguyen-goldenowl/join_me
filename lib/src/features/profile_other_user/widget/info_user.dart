import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/theme/colors.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.white,
              border: const GradientBoxBorder(
                gradient: LinearGradient(colors: AppColors.gradient),
                width: 3,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Assets.images.images.avatar.image(),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Emiliano Vittorisosi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "12 Events",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(width: 20),
            Text(
              "200 Follower",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: AppColors.rosyPink,
            foregroundColor: AppColors.white,
          ),
          child: const Text("Follow"),
        )
      ],
    );
  }
}
