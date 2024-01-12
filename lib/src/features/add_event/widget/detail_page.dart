import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/forms/input.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEventBloc addEventBloc = BlocProvider.of<AddEventBloc>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Detail event",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.name != current.event.name,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_nameEventInput_textField'),
                    value: state.event.name ?? "",
                    onChanged: (value) {
                      addEventBloc.setNameEvent(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Name Event",
                    ),
                  );
                }),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.description != current.event.description,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_descriptionEventInput_textField'),
                    minLines: 1,
                    maxLines: 30,
                    value: state.event.description ?? "",
                    onChanged: (value) {
                      addEventBloc.setDescriptionEvent(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Description",
                    ),
                  );
                }),
            const SizedBox(height: 10),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.type != current.event.type,
                builder: (context, state) {
                  return DropdownButtonFormField(
                    hint: const Text(
                      "Type Event",
                      style: TextStyle(
                        color: Color(0xCC50555C),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    value: state.event.type,
                    items: TypeEvent.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: ((value) {
                      addEventBloc.setType(value as TypeEvent);
                    }),
                  );
                }),
            const SizedBox(height: 10),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.maxAttendee != current.event.maxAttendee,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_numberMemberEventInput_textField'),
                    value: state.event.maxAttendee.toString(),
                    onChanged: (value) {
                      if (int.tryParse(value) != null) {
                        addEventBloc.setNumberMemberEvent(int.tryParse(value));
                      }
                      if (value == "") {
                        addEventBloc.setNumberMemberEvent(0);
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Maximum number of attendees",
                    ),
                  );
                }),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.startDate != current.event.startDate,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_startDateEventInput_textField'),
                    readOnly: true,
                    value: DateHelper.getFullDateTypeVN(state.event.startDate),
                    decoration: const InputDecoration(
                      labelText: "Start day",
                    ),
                    onChanged: (value) {
                      if (value == "") addEventBloc.setStartDateEvent(null);
                    },
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null &&
                          selectedDate != DateTime.now()) {
                        addEventBloc.setStartDateEvent(selectedDate);
                      }
                    },
                  );
                }),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) => previous.time != current.time,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_timeEventInput_textField'),
                    readOnly: true,
                    value:
                        state.time != null ? state.time!.format(context) : "",
                    decoration: const InputDecoration(
                      labelText: "Time",
                    ),
                    onChanged: (value) {
                      if (value == "") addEventBloc.setTimeEvent(null);
                    },
                    onTap: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        addEventBloc.setTimeEvent(selectedTime);
                      }
                    },
                  );
                }),
            BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) =>
                    previous.event.deadline != current.event.deadline,
                builder: (context, state) {
                  return XInput(
                    key: const Key('addEvent_deadlineEventInput_textField'),
                    readOnly: true,
                    value: DateHelper.getFullDateTypeVN(state.event.deadline!),
                    decoration: const InputDecoration(
                      labelText: "Registration expiration date",
                    ),
                    onChanged: (value) {
                      if (value == "") addEventBloc.setDeadlineEvent(null);
                    },
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null &&
                          selectedDate != DateTime.now()) {
                        addEventBloc.setDeadlineEvent(selectedDate);
                      }
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
