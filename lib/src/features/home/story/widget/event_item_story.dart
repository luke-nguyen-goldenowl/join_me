import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

// ignore: must_be_immutable
class EventItem extends StatelessWidget {
  EventItem({
    super.key,
    required this.storyId,
    required this.handlePress,
  });

  final String storyId;
  void Function() handlePress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handlePress,
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
            const Text(
              "Dec 12, 2023 - 11:00 PM ",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 15,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Let's play different famous board games, get together every Sunday",
              style: TextStyle(
                wordSpacing: 0,
                letterSpacing: 0,
                color: AppColors.black,
                fontSize: 18,
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
                  text: const TextSpan(children: [
                TextSpan(
                  text: "Followed: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
                TextSpan(
                  text: "100",
                  style: TextStyle(
                      color: AppColors.rosyPink,
                      fontSize: 20,
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
