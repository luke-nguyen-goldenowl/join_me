import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/data/list_image.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:myapp/src/features/detail_event/widget/indicator_image_list.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
        buildWhen: (previous, current) => previous != current,
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
                      if (images.isNotEmpty)
                        Image.network(
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
                      listImage.length,
                      (index) => IndicatorImageList(
                        isActive: index == state.indexPageImage,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
