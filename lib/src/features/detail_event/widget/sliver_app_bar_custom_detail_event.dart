import 'package:flutter/material.dart';
import 'package:myapp/src/features/detail_event/widget/background_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class SliverAppBarCustomDetailEvent extends StatelessWidget {
  const SliverAppBarCustomDetailEvent({
    this.actions,
    required this.images,
    required this.setIndexPageImage,
    required this.indexPageImage,
    required this.controller,
  });

  final List<String> images;
  final Function(int index) setIndexPageImage;
  final int indexPageImage;
  final PageController controller;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      foregroundColor: AppColors.white,
      expandedHeight: 200,
      actions: actions,
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  images[0],
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          FlexibleSpaceBar(
            background: BackgroundWidget(
              images: images,
              setIndexPageImage: setIndexPageImage,
              indexPageImage: indexPageImage,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
