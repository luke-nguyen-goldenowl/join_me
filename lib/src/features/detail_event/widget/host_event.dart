import 'package:flutter/material.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class HostEvent extends StatelessWidget {
  const HostEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCoordinator.showProfileOtherUser(id: '1');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Assets.images.images.avatar.image(
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Emiliano Vittoriosi",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 35,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.rosyPink.withOpacity(0.1),
                  foregroundColor: AppColors.rosyPink,
                ),
                child: const Text(
                  "Follow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
