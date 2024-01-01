// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ManageEventState {
  MPagination<MEvent> pagination;
  ManageEventState({
    required this.pagination,
  });

  factory ManageEventState.ds() {
    return ManageEventState(pagination: MPagination<MEvent>());
  }

  @override
  bool operator ==(covariant ManageEventState other) {
    if (identical(this, other)) return true;

    return other.pagination == pagination;
  }

  @override
  int get hashCode => pagination.hashCode;

  ManageEventState copyWith({
    MPagination<MEvent>? pagination,
  }) {
    return ManageEventState(
      pagination: pagination ?? this.pagination,
    );
  }
}
