import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/followed/upcoming/logic/upcoming_state.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class UpcomingBloc extends Cubit<UpComingState> {
  UpcomingBloc() : super(UpComingState.ds());

  Future<void> loadMore() async {
    MPagination<int> pagination = MPagination<int>();

    await Future.delayed(Duration(seconds: 2));

    pagination = pagination.addAll([
      ...state.pagination.data,
      ...List.generate(5, (index) => state.pagination.data.length + index)
    ]);

    if (!isClosed) return emit(state.copyWith(pagination: pagination));
  }
}
