// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class ManageEventState extends PaginationState {
  const ManageEventState({required super.data});

  @override
  ManageEventState copyWith({MPagination? data}) {
    return ManageEventState(data: data ?? this.data);
  }
}
