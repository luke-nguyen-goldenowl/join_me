// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class AttendedState extends PaginationState {
  AttendedState({required super.data, required this.userId});
  String userId;
  @override
  AttendedState copyWith({
    MPagination? data,
    String? userId,
  }) {
    return AttendedState(
      data: data ?? this.data,
      userId: userId ?? this.userId,
    );
  }
}
