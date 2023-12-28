enum TypeNotify { followEvent, followUser, upcomingEvent, changeEvent }

class NotifyState {
  List<dynamic> notifies;
  NotifyState({
    required this.notifies,
  });

  factory NotifyState.ds() {
    return NotifyState(notifies: []);
  }

  NotifyState copyWith({
    List<dynamic>? notifies,
  }) {
    return NotifyState(
      notifies: notifies ?? this.notifies,
    );
  }
}
