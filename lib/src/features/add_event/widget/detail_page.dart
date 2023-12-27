import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';

import 'package:myapp/widgets/forms/input.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEventBloc addEventBloc = BlocProvider.of<AddEventBloc>(context);
    return BlocBuilder<AddEventBloc, AddEventState>(builder: (context, state) {
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
                    value: state.nameEvent,
                    onChanged: (value) {
                      addEventBloc.setNameEvent(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Name Event",
                    ),
                  ),
                  XInput(
                    key: const Key('addEvent_descriptionEventInput_textField'),
                    minLines: 1,
                    maxLines: 10,
                    value: state.description,
                    onChanged: (value) {
                      addEventBloc.setDescriptionEvent(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Description",
                    ),
                  ),
                  XInput(
                    key: const Key('addEvent_numberMemberEventInput_textField'),
                    value: state.numberMember.toString(),
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
                  ),

                  XInput(
                    key: const Key('addEvent_startDateEventInput_textField'),
                    readOnly: true,
                    value: state.startDate != null
                        ? DateFormat("dd/MM/yyyy").format(state.startDate!)
                        : "",
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
                  ),

                  XInput(
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
                  ),

                  XInput(
                    key: const Key('addEvent_deadlineEventInput_textField'),
                    readOnly: true,
                    value: state.deadlineDate != null
                        ? DateFormat("dd/MM/yyyy").format(state.deadlineDate!)
                        : "",
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
                  ),

                  // TextFormField(
                  //   controller: state.nameController,
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   decoration: const InputDecoration(
                  //     labelText: 'Name event',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter a name event';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   controller: state.descriptionController,
                  //   minLines: 1,
                  //   maxLines: 5,
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   decoration: const InputDecoration(
                  //     labelText: 'Description',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter a description';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   controller: state.numberMemberController,
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   decoration: const InputDecoration(
                  //     labelText: 'Maximum number of attendees',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   keyboardType: TextInputType.number,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter the maximum number of members';
                  //     }
                  //     if (int.tryParse(value) == null) {
                  //       return 'Please enter a valid number';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   readOnly: true,
                  //   controller: state.dateController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Start day',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     DateTime? selectedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2101),
                  //     );
                  //     if (selectedDate != null &&
                  //         selectedDate != DateTime.now()) {
                  //       state.dateController.text =
                  //           DateFormat("dd/MM/yyyy").format(selectedDate);
                  //     }
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   readOnly: true,
                  //   controller: state.timeController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Time',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     TimeOfDay? selectedTime = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.now(),
                  //     );
                  //     if (selectedTime != null &&
                  //         selectedTime != TimeOfDay.now()) {
                  //       state.timeController.text =
                  //           // ignore: use_build_context_synchronously
                  //           selectedTime.format(context);
                  //     }
                  //   },
                  // ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   readOnly: true,
                  //   controller: state.deadlineController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Registration expiration date',
                  //     labelStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.grey,
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     DateTime? selectedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2101),
                  //     );
                  //     if (selectedDate != null &&
                  //         selectedDate != DateTime.now()) {
                  //       state.deadlineController.text =
                  //           DateFormat("dd/MM/yyyy").format(selectedDate);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
