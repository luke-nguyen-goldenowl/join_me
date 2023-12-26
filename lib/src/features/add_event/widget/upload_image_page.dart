import 'dart:io';

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
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  context.read<AddEventBloc>().selectMedias();
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.iceBlue,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: state.medias.length == 5 && state.medias[4] != null
                      ? InkWell(
                          onTap: (() {
                            context.read<AddEventBloc>().removeImage(4);
                          }),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              File(state.medias[4]!.path),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Center(
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
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.iceBlue,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: state.medias.length > index &&
                            state.medias[index] != null
                        ? InkWell(
                            onTap: () {
                              context.read<AddEventBloc>().removeImage(index);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(state.medias[index]!.path),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: AppColors.rosyPink,
                            ),
                          ),
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
