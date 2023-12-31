import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/followed/past/logic/past_state.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class PastBloc extends Cubit<PastState> {
  PastBloc() : super(PastState.ds());

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
