import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class ListEventFavoriteState extends PaginationState {
  const ListEventFavoriteState({required super.data});

  @override
  ListEventFavoriteState copyWith({MPagination? data}) {
    return ListEventFavoriteState(data: data ?? this.data);
  }
}
