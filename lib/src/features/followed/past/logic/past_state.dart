// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class PastState {
  MPagination<int> pagination;
  PastState({
    required this.pagination,
  });

  factory PastState.ds() {
    return PastState(pagination: MPagination<int>());
  }

  @override
  bool operator ==(covariant PastState other) {
    if (identical(this, other)) return true;

    return other.pagination == pagination;
  }

  @override
  int get hashCode => pagination.hashCode;

  PastState copyWith({
    MPagination<int>? pagination,
  }) {
    return PastState(
      pagination: pagination ?? this.pagination,
    );
  }
}
