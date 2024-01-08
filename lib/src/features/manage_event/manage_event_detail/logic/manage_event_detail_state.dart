class ManageEventDetailState {
  int indexPageImage;

  ManageEventDetailState({this.indexPageImage = 0});

  ManageEventDetailState copyWith({indexPageImage}) {
    return ManageEventDetailState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
    );
  }

  @override
  bool operator ==(covariant ManageEventDetailState other) {
    if (identical(this, other)) return true;

    return other.indexPageImage == indexPageImage;
  }

  @override
  int get hashCode => indexPageImage.hashCode;
}
