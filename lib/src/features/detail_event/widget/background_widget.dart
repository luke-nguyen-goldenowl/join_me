import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:myapp/src/features/detail_event/widget/indicator_image_list.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.images,
    required this.setIndexPageImage,
    required this.indexPageImage,
    required this.controller,
  });

  final List<String> images;
  final Function(int index) setIndexPageImage;
  final int indexPageImage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
      buildWhen: (previous, current) =>
          previous.indexPageImage != current.indexPageImage,
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              onPageChanged: ((value) {
                context.read<DetailEventBloc>().setIndexPageImage(value);
              }),
              itemCount: images.length,
              controller: context.read<DetailEventBloc>().controller,
              itemBuilder: ((context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    images.length,
                    (index) => IndicatorImageList(
                      isActive: index == indexPageImage,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
