import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/home/logic/event_item_bloc.dart';
import 'package:myapp/src/features/home/logic/event_item_state.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class EventItemHome extends StatelessWidget {
  const EventItemHome({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCoordinator.showEventDetails(id: "4f");
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.images.bgEvent.provider(),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderEvent(),
            BottomEvent(),
          ],
        ),
      ),
    );
  }
}

class BottomEvent extends StatelessWidget {
  const BottomEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "California Art Festival: Drawings on the pavement",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Starts at 9:00 AM",
            style: TextStyle(fontSize: 15, color: AppColors.grey),
          )
        ],
      ),
    );
  }
}

class HeaderEvent extends StatelessWidget {
  const HeaderEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventItemBloc, EventItemState>(
        buildWhen: (previous, current) {
      return previous.isLiked != current.isLiked;
    }, builder: (context, state) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "12",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Dec",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<EventItemBloc>().setIsLike();
            },
            icon: Icon(state.isLiked
                ? Icons.favorite
                : Icons.favorite_border_outlined),
            style: IconButton.styleFrom(
              foregroundColor:
                  state.isLiked ? AppColors.rosyPink : AppColors.white,
            ),
            iconSize: 30,
          )
        ],
      );
    });
  }
}
