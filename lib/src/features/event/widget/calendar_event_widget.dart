// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/theme/colors.dart';

class CalendarEventWidget extends StatelessWidget {
  const CalendarEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EventViewBloc eventBloc = BlocProvider.of<EventViewBloc>(context);
    return BlocBuilder<EventViewBloc, EventViewState>(
      buildWhen: (previousState, currentState) {
        return previousState.firstDate != currentState.firstDate ||
            previousState.lastDate != currentState.lastDate ||
            previousState.typeShow != currentState.typeShow ||
            !listEquals(previousState.weekDays, currentState.weekDays) ||
            !listEquals(previousState.types, currentState.types);
      },
      builder: ((context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat('MMMM dd').format(state.firstDate)} - ${DateFormat('MMMM dd').format(state.lastDate)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (picked != null) {
                      eventBloc.updateWeekDays(picked);
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 25,
                  ),
                )
              ],
            ),
            Text(
              DateFormat('MMMM, yyyy').format(state.firstDate),
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(state.weekDays.length, (index) {
                  return Container(
                    height: double.infinity,
                    width: 35,
                    decoration: index == 0 || index == 6
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0.5, 0.5),
                              ),
                            ],
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          state.weekDays[index].day.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: index == 6
                                ? AppColors.rosyPink
                                : AppColors.black,
                          ),
                        ),
                        Text(
                          DateFormat("EE")
                              .format(state.weekDays[index])
                              .substring(0, 2)
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: index == 6
                                ? AppColors.rosyPink
                                : AppColors.grey,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            )
          ],
        );
      }),
    );
  }
}
