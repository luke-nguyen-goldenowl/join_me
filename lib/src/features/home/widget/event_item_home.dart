import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class EventItemHome extends StatelessWidget {
  const EventItemHome(
      {super.key,
      required this.event,
      required this.index,
      required this.type});
  final MEvent event;
  final int index;
  final TypeListEventHome type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeBloc>().goDetailEvent(index, event);
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(event.images?[0] ?? "").image,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderEvent(),
            _buildBottomEvent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomEvent() {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      // height: 130,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.text,
            ),
          ),
          Text(
            "Starts at ${DateHelper.getTime(event.startDate)}",
            style: const TextStyle(fontSize: 15, color: AppColors.grey),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderEvent() {
    return Container(
      alignment: Alignment.center,
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            event.startDate?.day.toString() ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          Text(
            DateHelper.getShortMonth(event.startDate),
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
