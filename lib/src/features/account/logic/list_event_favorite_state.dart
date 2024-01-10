import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ListEventFavoriteState extends PaginationState<MEvent> {
  const ListEventFavoriteState({required super.data});

  @override
  ListEventFavoriteState copyWith({MPagination<MEvent>? data}) {
    return ListEventFavoriteState(data: data ?? this.data);
  }
}
