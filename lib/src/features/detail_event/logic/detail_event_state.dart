class DetailEventState {
  int indexPageImage;

  DetailEventState({this.indexPageImage = 0});

  DetailEventState copyWith({indexPageImage}) {
    return DetailEventState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
    );
  }
}
