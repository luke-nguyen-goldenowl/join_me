import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/story_item_state.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';

class StoryItemBloc extends Cubit<StoryItemState> {
  StoryItemBloc({required List<MStory> stories, required MUser host})
      : super(StoryItemState(stories: stories, host: host));

  void setIsView() {}
}
