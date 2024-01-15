// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryViewExtra {
  String id;
  List<MUserStory> userStory;
  Function(int, int) handleSeenStory;
  StoryViewExtra({
    required this.id,
    required this.userStory,
    required this.handleSeenStory,
  });

  StoryViewExtra copyWith({
    String? id,
    List<MUserStory>? userStory,
    Function(int, int)? handleSeenStory,
  }) {
    return StoryViewExtra(
      id: id ?? this.id,
      userStory: userStory ?? this.userStory,
      handleSeenStory: handleSeenStory ?? this.handleSeenStory,
    );
  }
}
