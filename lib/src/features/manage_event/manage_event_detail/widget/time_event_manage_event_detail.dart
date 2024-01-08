import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class TimeEventMangeEventDetail extends StatelessWidget {
  const TimeEventMangeEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.access_time,
              color: AppColors.black,
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '12 December, 2023',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'At 11:00 AM',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
