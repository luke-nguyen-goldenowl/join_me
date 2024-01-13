import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/event/logic/list_event_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ListEventBloc extends PaginationBloc<ListEventState> {
  ListEventBloc({
    required DateTime firstDate,
    required DateTime lastDate,
    required List<TypeEvent> types,
  }) : super(ListEventState(
          data: MPagination<MEvent>(),
          firstDate: firstDate,
          lastDate: lastDate,
          types: types,
        ));
  DomainManager get domain => DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  @override
  Future<MResult<MPaginationResponse<MEvent>>> get getDataAPI async {
    final data = await domain.event.getEventsByFilter(
        state.types, state.firstDate, state.lastDate, state.data.lastDoc);

    final MPaginationMeta meta;
    if (state.data.countData == -1) {
      final totalCount = await domain.event
          .getCountEventsByFilter(state.types, state.firstDate, state.lastDate);
      meta = MPaginationMeta(
        pageSize: state.data.pageLimit,
        totalCount: totalCount.data ?? 0,
        pageNumber: (totalCount.data ?? 0 / state.data.pageLimit).ceil(),
        lastPage: (totalCount.data ?? 0 / state.data.pageLimit).ceil(),
      );
    } else {
      meta = MPaginationMeta(
        pageSize: state.data.pageLimit,
        totalCount: state.data.countData,
        pageNumber: (state.data.countData / state.data.pageLimit).ceil(),
        lastPage: (state.data.countData / state.data.pageLimit).ceil(),
      );
    }
    final paginationResponse =
        MPaginationResponse<MEvent>(data: data.data ?? [], meta: meta);
    return MResult.success(paginationResponse);
  }
}
