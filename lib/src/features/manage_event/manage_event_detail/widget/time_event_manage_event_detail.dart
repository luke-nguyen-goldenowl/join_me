import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class TimeEventMangeEventDetail extends StatelessWidget {
  const TimeEventMangeEventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
      buildWhen: (previous, current) =>
          previous.event.startDate != current.event.startDate,
      builder: ((context, state) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateHelper.getFullDate(state.event.startDate),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'At ${DateHelper.getTime(state.event.startDate)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
