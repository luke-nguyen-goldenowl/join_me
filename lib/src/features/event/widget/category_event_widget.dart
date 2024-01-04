import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/features/event/logic/type_event.dart';
import 'package:myapp/src/theme/colors.dart';

class CategoryEventWidget extends StatelessWidget {
  const CategoryEventWidget({super.key});

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
        return Container(
          margin: const EdgeInsets.only(right: 10),
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryEvents.length,
            itemBuilder: ((contextListView, index) {
              return Row(
                children: [
                  ChoiceChip.elevated(
                    showCheckmark: false,
                    avatar: Icon(categoryEvents[index].icon),
                    onSelected: (value) {
                      eventBloc.updateTypes(categoryEvents[index].type);
                    },
                    label: Text(categoryEvents[index].type.name),
                    selected: state.types.contains(categoryEvents[index].type),
                    selectedColor: AppColors.rosyPink.withOpacity(0.7),
                    backgroundColor: AppColors.background,
                  ),
                  const SizedBox(width: 10),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
