import 'package:myapp/src/network/data/story/story_reference.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/story/story.dart';

import 'package:myapp/src/network/model/user_story/user_story.dart';

class UserStoryRepositoryImpl {
  final UserReference usersRef = UserReference();
  final StoryReference storyReference = StoryReference();
  Future<MResult<List<MUserStory>>> getUserStoryByIds(
      List<String> userIds) async {
    try {
      final users = await usersRef.getUsersByIds(userIds);
      List<Future<MResult<List<MStory>>>> futures = userIds.map((userId) {
        return storyReference.getStoriesByUser(userId);
      }).toList();

      List<MResult<List<MStory>>> listStories = await Future.wait(futures);
      List<MUserStory> result = [];
      if (users.data == null) {
        return MResult.success(result);
      }
      for (int i = 0; i < listStories.length; i++) {
        if (listStories[i].isSuccess) {
          result.add(
              MUserStory(user: users.data![i], stories: listStories[i].data!));
        }
      }
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
