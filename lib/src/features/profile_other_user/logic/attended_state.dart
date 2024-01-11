// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class AttendedState extends PaginationState<MEvent> {
  const AttendedState({required super.data});

  @override
  AttendedState copyWith({MPagination<MEvent>? data}) {
    return AttendedState(data: data ?? this.data);
  }
}
