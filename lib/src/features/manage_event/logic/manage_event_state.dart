// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ManageEventState extends PaginationState<MEvent> {
  const ManageEventState({required super.data});

  @override
  ManageEventState copyWith({MPagination<MEvent>? data}) {
    return ManageEventState(data: data ?? this.data);
  }
}
