import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class DescriptionEvent extends StatelessWidget {
  const DescriptionEvent({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About this event",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}
