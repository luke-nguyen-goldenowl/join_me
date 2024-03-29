import 'package:flutter/material.dart';
import 'package:myapp/src/features/detail_event/widget/indicator_image_list.dart';
import 'package:myapp/widgets/image/image_network.dart';

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
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          onPageChanged: ((value) {
            setIndexPageImage(value);
          }),
          itemCount: images.length,
          controller: controller,
          itemBuilder: ((context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                XImageNetwork(
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
  }
}
