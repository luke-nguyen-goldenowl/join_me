import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_bloc.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';
import 'package:myapp/src/theme/colors.dart';

class UploadImagePage extends StatelessWidget {
  const UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.medias, current.medias),
      builder: (context, state) {
        return Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Upload a photo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.iceBlue,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: state.medias.isNotEmpty && state.medias[0] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Image.file(
                              File(state.medias[0]!.path),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton.outlined(
                                  onPressed: (() {
                                    context.read<AddEventBloc>().removeImage(0);
                                  }),
                                  icon: const Icon(
                                    Icons.close,
                                  ),
                                  color: AppColors.white,
                                  iconSize: 15,
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        AppColors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          context.read<AddEventBloc>().selectMedias();
                        },
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 50,
                                color: AppColors.rosyPink,
                              ),
                              Text("Click or drop image")
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                // textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.iceBlue,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: state.medias.length - 1 > index &&
                            state.medias[index + 1] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(state.medias[index + 1]!.path),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 3,
                                  top: 3,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: IconButton.outlined(
                                      onPressed: (() {
                                        context
                                            .read<AddEventBloc>()
                                            .removeImage(index + 1);
                                      }),
                                      icon: const Icon(
                                        Icons.close,
                                        size: 10,
                                      ),
                                      color: AppColors.white,
                                      style: IconButton.styleFrom(
                                        backgroundColor:
                                            AppColors.black.withOpacity(0.3),
                                        padding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              context.read<AddEventBloc>().selectMedias();
                            },
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: AppColors.rosyPink,
                              ),
                            ),
                          ),
                  );
                }),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}
