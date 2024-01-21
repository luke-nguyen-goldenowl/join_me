import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class TimeEvent extends StatelessWidget {
  const TimeEvent({
    super.key,
    required this.startDate,
    required this.followers,
    required this.endDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 10),
              if (startDate != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From ${DateHelper.getFullDateTimeFullMonth(startDate)}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "To ${DateHelper.getFullDate(endDate)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            ],
          ),
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.rosyPink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "+$followers",
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
