// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class PastState extends PaginationState<MEvent> {
  const PastState({required super.data});

  @override
  PastState copyWith({MPagination<MEvent>? data}) {
    return PastState(data: data ?? this.data);
  }
}
