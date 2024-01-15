import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';

import '../handle.dart';
import '../result.dart';

class MPagination<T> {
  MPagination({
    this.pageLimit = defaultPageLimit,
    this.data = const [],
    this.hasMore = true,
    this.getFirst = false,
    this.status = MStatus.initial,
  });

  static const int defaultPageLimit = 1;

  final int pageLimit;
  final bool getFirst;

  List<T> data;
  final MStatus status;
  final bool hasMore;
  bool get canNext => hasMore && status == MStatus.initial;
  bool get canLoad => hasMore && status != MStatus.loading;

  T? get lastDoc => data.isNotEmpty ? data.last : null;

  bool get isLoading => status.isLoading;
  bool get isFirstLoading => status.isLoading && data.isEmpty;
  bool get isFirstError => status.isFailure && data.isEmpty;
  bool get isEmpty => status == MStatus.initial && data.isEmpty;
  bool get isPure => status == MStatus.initial;
  MPagination<T> addAll(List<T> items) {
    final data = [...this.data, ...items];
    return this.copyWith(
      data: data,
      hasMore: (!this.getFirst || items.length == this.pageLimit),
      getFirst: !this.getFirst ? true : null,
      status: MStatus.initial,
    );
  }

  MPagination<T> addAllFromModel(MPaginationResponse<T> model) {
    final data = [...this.data, ...model.data];
    return this.copyWith(
      data: data,
      hasMore: (!this.getFirst || model.data.length == this.pageLimit),
      getFirst: !this.getFirst ? true : null,
      status: MStatus.initial,
    );
  }

  MPagination<T> addAllFromResult(MResult<MPaginationResponse<T>> result) {
    if (result.isSuccess && result.data != null) {
      return this.addAllFromModel(result.data!);
    } else {
      return this.copyWith(status: MStatus.failure);
    }
  }

  MPagination<T> toLoading() {
    return copyWith(status: MStatus.loading);
  }

  MPagination<T> copyWith({
    List<T>? data,
    int? pageLimit,
    MStatus? status,
    bool? hasMore,
    bool? getFirst,
  }) {
    return MPagination<T>(
        data: data ?? this.data,
        pageLimit: pageLimit ?? this.pageLimit,
        status: status ?? this.status,
        hasMore: hasMore ?? this.hasMore,
        getFirst: getFirst ?? this.getFirst);
  }
}
