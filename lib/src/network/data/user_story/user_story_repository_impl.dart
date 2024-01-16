import 'package:myapp/src/network/data/story/story_reference.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';

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
          if (listStories[i].data?.isNotEmpty ?? false) {
            final MUser user = users.data?.firstWhere((element) =>
                    element.id == listStories[i].data?[0].host?.id) ??
                MUser.empty();
            result.add(
                MUserStory(user: user, stories: listStories[i].data ?? []));
          }
        }
      }
      int index = result.indexWhere((element) => element.user.id == userIds[0]);
      if (index != -1) {
        MUserStory userStory = result.removeAt(index);
        result.insert(0, userStory);
      }
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MUserStory>> getUserStoryById(String userId) async {
    try {
      final user = await usersRef.getUser(userId);
      final stories = await storyReference.getStoriesByUser(userId);

      if (user.isSuccess && stories.isSuccess) {
        final MUserStory userStory =
            MUserStory(user: user.data!, stories: stories.data!);
        return MResult.success(userStory);
      }

      return MResult.error("Some error");
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
