import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryViewExtra {
  List<MUserStory> userStory;
  Function(int, int) handleSeenStory;
  StoryViewExtra({
    required this.userStory,
    required this.handleSeenStory,
  });

  StoryViewExtra copyWith({
    List<MUserStory>? userStory,
    Function(int, int)? handleSeenStory,
  }) {
    return StoryViewExtra(
      userStory: userStory ?? this.userStory,
      handleSeenStory: handleSeenStory ?? this.handleSeenStory,
    );
  }
}
