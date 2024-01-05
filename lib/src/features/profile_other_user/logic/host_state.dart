// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class HostState extends PaginationState<MEvent> {
  const HostState({required super.data});

  @override
  HostState copyWith({MPagination<MEvent>? data}) {
    return HostState(data: data ?? this.data);
  }
}
