import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ListEventFavoriteState extends PaginationState<MEvent> {
  const ListEventFavoriteState({required this.userId, required super.data});
  final String userId;
  @override
  ListEventFavoriteState copyWith({MPagination<MEvent>? data, String? userId}) {
    return ListEventFavoriteState(
        data: data ?? this.data, userId: userId ?? this.userId);
  }
}
