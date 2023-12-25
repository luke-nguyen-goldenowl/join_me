import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/features/add_event/widget/address_page.dart';
import 'package:myapp/src/features/add_event/widget/detail_page.dart';
import 'package:myapp/src/features/add_event/widget/upload_image_page.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEventBloc(),
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
    return BlocBuilder<AddEventBloc, AddEventState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: const AppBarCustom(
            title: "Create New Event",
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => _buildIndicator(state.currentPage == index, size),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    context.read<AddEventBloc>().setCurrentPage(value);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  controller: state.controller,
                  children: const [
                    UploadImagePage(),
                    AddressPage(),
                    DetailPage(),
                  ],
                ),
              ),
              _buildBottomEvent(
                  context, state.controller, state.currentPage, state.formKey)
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomEvent(BuildContext context, PageController controller,
      int currentPage, GlobalKey<FormState> formKey) {
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
              if (currentPage != 2) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              } else if (formKey.currentState!.validate()) {
                context.read<AddEventBloc>().setFormDetailEvent();
                AppCoordinator.pop();
              }
            },
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
