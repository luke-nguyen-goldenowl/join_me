// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ListEventState extends PaginationState<MEvent> {
  ListEventState({
    required super.data,
    required this.firstDate,
    required this.lastDate,
    required this.types,
  });

  List<TypeEvent> types;
  DateTime firstDate;
  DateTime lastDate;

  @override
  ListEventState copyWith({
    MPagination<MEvent>? data,
    List<TypeEvent>? types,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return ListEventState(
      data: data ?? this.data,
      types: types ?? this.types,
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate ?? this.lastDate,
    );
  }
}
