// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class UpComingState extends PaginationState<MEvent> {
  const UpComingState({required super.data});

  @override
  UpComingState copyWith({MPagination<MEvent>? data}) {
    return UpComingState(data: data ?? this.data);
  }
}
