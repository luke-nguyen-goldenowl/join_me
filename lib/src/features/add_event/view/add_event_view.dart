import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/features/add_event/widget/address_page.dart';
import 'package:myapp/src/features/add_event/widget/detail_page.dart';
import 'package:myapp/src/features/add_event/widget/upload_image_page.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/utils.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({
    super.key,
    this.event,
  });
  final MEvent? event;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEventBloc(event: event),
      child: const AddEventPage(),
    );
  }
}

class AddEventPage extends StatelessWidget {
  const AddEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(
        title: BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) => previous.event != current.event,
          builder: ((context, state) {
            return Text(
              state.event.id?.isEmpty ?? true
                  ? "Create New Event"
                  : "Edit Event",
            );
          }),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<AddEventBloc, AddEventState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            builder: ((context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => _buildIndicator(state.currentPage == index, size),
                ),
              );
            }),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                context.read<AddEventBloc>().setCurrentPage(value);
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: context.read<AddEventBloc>().controller,
              children: const [
                UploadImagePage(),
                AddressPage(),
                DetailPage(),
              ],
            ),
          ),
          BlocBuilder<AddEventBloc, AddEventState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            builder: ((context, state) {
              return _buildBottomEvent(
                context,
                context.read<AddEventBloc>().controller,
                state.currentPage,
                state.event,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomEvent(BuildContext context, PageController controller,
      int currentPage, MEvent event) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentPage != 0
              ? OutlinedButton(
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
                    foregroundColor: AppColors.text,
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          ElevatedButton(
            onPressed: context.watch<AddEventBloc>().state.checkValidate()
                ? () {
                    if (currentPage != 2) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                      if (currentPage == 0) {
                        context.read<AddEventBloc>().getCurrentLocation();
                      }
                    } else {
                      if (isNullOrEmpty(event.id)) {
                        context.read<AddEventBloc>().addEvent();
                      } else {
                        context.read<AddEventBloc>().editEvent();
                      }
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rosyPink,
              minimumSize: const Size(100, 50),
              foregroundColor: AppColors.white,
            ),
            child: Text(
              currentPage != 2 ? "Next" : "Post",
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
      width: size.width / 3 - 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? AppColors.rosyPink : AppColors.grey5,
      ),
    );
  }
}
