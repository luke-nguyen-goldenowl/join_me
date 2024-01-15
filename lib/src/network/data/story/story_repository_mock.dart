import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryRepositoryMock {
  MResult<MStory> getStory(String id) {
    final MStory result =
        MStory(id: id, host: MUser.empty(), event: MEvent(id: id));
    return MResult.success(result);
  }

  MResult<MUserStory> getEventsByUser(MUser user) {
    final MUserStory result = MUserStory(user: user, stories: []);
    return MResult.success(result);
  }
}
