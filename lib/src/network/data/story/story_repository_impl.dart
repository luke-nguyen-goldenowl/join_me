import 'package:myapp/src/network/data/story/story_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/story/story.dart';

class StoryRepositoryImpl {
  final StoryReference storyReference = StoryReference();
  Future<MResult<MStory>> addStory(MStory story) {
    return storyReference.addStory(story);
  }

  Future<MResult> updateViewerStory(String storyId, String userId) async {
    return storyReference.updateViewerStory(storyId, userId);
  }
}
