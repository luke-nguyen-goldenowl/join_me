// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailEventState {
  int indexPageImage;

  DetailEventState({this.indexPageImage = 0});

  DetailEventState copyWith({indexPageImage}) {
    return DetailEventState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
    );
  }

  @override
  bool operator ==(covariant DetailEventState other) {
    if (identical(this, other)) return true;

    return other.indexPageImage == indexPageImage;
  }

  @override
  int get hashCode => indexPageImage.hashCode;
}
