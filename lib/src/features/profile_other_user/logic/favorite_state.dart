// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class FavoriteState extends PaginationState<MEvent> {
  const FavoriteState({required super.data});

  @override
  FavoriteState copyWith({MPagination<MEvent>? data}) {
    return FavoriteState(data: data ?? this.data);
  }
}
