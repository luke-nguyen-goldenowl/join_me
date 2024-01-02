import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';

abstract class PaginationBloc<T extends PaginationState> extends Cubit<T> {
  PaginationBloc(super.initialState) {
    getData();
  }

  Future<MResult<MPaginationResponse>> get getDataAPI;

  Future<void> getData() async {
    if (!GetIt.I<AccountBloc>().state.isLogin && state.needLogin) return;
    if (!state.data.canLoad) return;

    emit(state.copyWith(data: state.data.toLoading()) as T);

    final result = await getDataAPI;
    emit(state.copyWith(data: state.data.addAllFromResult(result)) as T);
  }

  Future<void> refreshData() async {
    if (state.data.isLoading) return;
    emit(state.copyWith(data: MPagination()) as T);
    getData();
  }
}

abstract class PaginationState<T> extends Equatable {
  const PaginationState({
    required this.data,
    this.needLogin = true,
  });

  final MPagination<T> data;
  final bool needLogin;

  @override
  List<Object?> get props => [data];

  PaginationState<T> copyWith({
    MPagination<T>? data,
  });
}
