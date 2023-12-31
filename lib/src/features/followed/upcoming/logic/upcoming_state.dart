// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

class UpComingState {
  MPagination<int> pagination;
  UpComingState({
    required this.pagination,
  });

  factory UpComingState.ds() {
    return UpComingState(pagination: MPagination<int>());
  }

  @override
  bool operator ==(covariant UpComingState other) {
    if (identical(this, other)) return true;

    return other.pagination == pagination;
  }

  @override
  int get hashCode => pagination.hashCode;

  UpComingState copyWith({
    MPagination<int>? pagination,
  }) {
    return UpComingState(
      pagination: pagination ?? this.pagination,
    );
  }
}
