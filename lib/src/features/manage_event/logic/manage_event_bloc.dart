import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/logic/manage_event_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ManageEventBloc extends Cubit<ManageEventState> {
  ManageEventBloc() : super(ManageEventState.ds());

  DomainManager get domain => DomainManager();

  Future<void> loadMore() async {
    MPagination<MEvent> pagination = MPagination<MEvent>();

    await Future.delayed(const Duration(seconds: 2));

    pagination = pagination.addAll(
        [...state.pagination.data, ...domain.event.getEventsByUser('1').data!]);

    if (!isClosed) return emit(state.copyWith(pagination: pagination));
  }

  Future<void> getData() async {
    MPagination<MEvent> pagination = MPagination<MEvent>();

    await Future.delayed(const Duration(seconds: 2));

    pagination = pagination.addAll(domain.event.getEventsByUser('1').data!);

    if (!isClosed) return emit(state.copyWith(pagination: pagination));
  }
}
