import 'package:flutter/material.dart';
import 'package:myapp/src/features/search/widget/event_search_widget.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

// ignore: must_be_immutable
class ListDataPaginationEvent<T> extends StatelessWidget {
  ListDataPaginationEvent(
      {super.key,
      required this.data,
      required this.getData,
      required this.onRefresh});

  MPagination<T> data;
  Function() getData;
  Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              itemCount: data.data.length + 1,
              itemBuilder: ((context, index) {
                if (index == data.data.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: XStatePaginationWidget(
                      page: data,
                      loadMore: getData,
                      autoLoad: true,
                    ),
                  );
                } else {
                  return EventSearchWidget(event: data.data[index] as MEvent);
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}
