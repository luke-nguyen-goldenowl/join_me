import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_bloc.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';

import 'package:myapp/widgets/forms/input.dart';

class DetailPageEditEvent extends StatelessWidget {
  const DetailPageEditEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final EditEventBloc editEventBloc = BlocProvider.of<EditEventBloc>(context);
    return BlocBuilder<EditEventBloc, EditEventState>(
        buildWhen: (previous, current) => previous.event != current.event,
        builder: (context, state) {
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
                  Column(
                    children: [
                      XInput(
                        key: const Key('addEvent_nameEventInput_textField'),
                        value: state.event.name ?? "",
                        onChanged: (value) {
                          editEventBloc.setNameEvent(value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Name Event",
                        ),
                      ),
                      XInput(
                        key: const Key(
                            'addEvent_descriptionEventInput_textField'),
                        minLines: 1,
                        maxLines: 10,
                        value: state.event.description ?? "",
                        onChanged: (value) {
                          editEventBloc.setDescriptionEvent(value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                      XInput(
                        key:
                            const Key('addEvent_startDateEventInput_textField'),
                        readOnly: true,
                        value: state.event.startDate != null
                            ? DateFormat("dd/MM/yyyy")
                                .format(state.event.startDate!)
                            : "",
                        decoration: const InputDecoration(
                          labelText: "Start day",
                        ),
                        onChanged: (value) {
                          if (value == "") {
                            editEventBloc.setStartDateEvent(null);
                          }
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
                            editEventBloc.setStartDateEvent(selectedDate);
                          }
                        },
                      ),
                      XInput(
                        key: const Key('addEvent_timeEventInput_textField'),
                        readOnly: true,
                        value: state.time != null
                            ? state.time!.format(context)
                            : "",
                        decoration: const InputDecoration(
                          labelText: "Time",
                        ),
                        onChanged: (value) {
                          if (value == "") editEventBloc.setTimeEvent(null);
                        },
                        onTap: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            editEventBloc.setTimeEvent(selectedTime);
                          }
                        },
                      ),
                      XInput(
                        key: const Key('addEvent_deadlineEventInput_textField'),
                        readOnly: true,
                        value: state.event.deadline != null
                            ? DateFormat("dd/MM/yyyy")
                                .format(state.event.deadline!)
                            : "",
                        decoration: const InputDecoration(
                          labelText: "Registration expiration date",
                        ),
                        onChanged: (value) {
                          if (value == "") editEventBloc.setDeadlineEvent(null);
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
                            editEventBloc.setDeadlineEvent(selectedDate);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
