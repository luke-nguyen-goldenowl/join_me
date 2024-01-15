// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class HostState extends PaginationState<MEvent> {
  HostState({required super.data, required this.userId});

  String userId;

  @override
  HostState copyWith({MPagination<MEvent>? data, String? userId}) {
    return HostState(data: data ?? this.data, userId: userId ?? this.userId);
  }
}
