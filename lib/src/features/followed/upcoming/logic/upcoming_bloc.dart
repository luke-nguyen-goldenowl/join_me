import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/followed/upcoming/logic/upcoming_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class UpcomingBloc extends PaginationBloc<UpComingState> {
  UpcomingBloc() : super(UpComingState(data: MPagination<MEvent>()));
  final user = GetIt.I<AccountBloc>().state.user;
  DomainManager get domain => DomainManager();
  @override
  Future<MResult<MPaginationResponse<MEvent>>> get getDataAPI async {
    final data =
        await domain.event.getEventsUpcomingByUser(user.id, state.data.lastDoc);

    final MPaginationMeta meta;
    if (state.data.countData == -1) {
      final totalCount =
          await domain.event.getCountEventsUpcomingByUser(user.id);
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
