// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class PastState extends PaginationState {
  const PastState({required super.data});

  @override
  PastState copyWith({MPagination? data}) {
    return PastState(data: data ?? this.data);
  }
}
