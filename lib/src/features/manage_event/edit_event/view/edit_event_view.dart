import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_bloc.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';
import 'package:myapp/src/features/manage_event/edit_event/widget/address_page_edit_event.dart';
import 'package:myapp/src/features/manage_event/edit_event/widget/detail_page_edit_event.dart';
import 'package:myapp/src/network/data/event/event_repository_mock.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class EditEvent extends StatelessWidget {
  const EditEvent({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditEventBloc()..initState(events[0]),
      child: const EditEventPage(),
    );
  }
}

class EditEventPage extends StatelessWidget {
  const EditEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<EditEventBloc, EditEventState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage ||
          previous.event != previous.event,
      builder: ((context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: const AppBarCustom(
            title: "Edit Event",
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => _buildIndicator(state.currentPage == index, size),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    context.read<EditEventBloc>().setCurrentPage(value);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  controller: context.read<EditEventBloc>().controller,
                  children: const [
                    AddressPageEditEvent(),
                    DetailPageEditEvent(),
                  ],
                ),
              ),
              _buildBottomEvent(context,
                  context.read<EditEventBloc>().controller, state.currentPage)
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBottomEvent(
      BuildContext context, PageController controller, int currentPage) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () {
              controller.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.iceBlue,
                width: 3,
              ),
              minimumSize: const Size(100, 50),
              foregroundColor: AppColors.black,
            ),
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (currentPage != 1) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              } else {
                AppCoordinator.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rosyPink,
              minimumSize: const Size(100, 50),
              foregroundColor: AppColors.white,
            ),
            child: Text(
              currentPage != 1 ? "Next" : "Save",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive, Size size) {
    return Container(
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: size.width / 2 - 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? AppColors.rosyPink : AppColors.grey5,
      ),
    );
  }
}
