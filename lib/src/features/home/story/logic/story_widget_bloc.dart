import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/model/story.dart';
import 'package:myapp/src/features/home/model/user.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_state.dart';
import 'package:story_view/story_view.dart';

class StoryWidgetBloc extends Cubit<StoryWidgetState> {
  StoryWidgetBloc() : super(StoryWidgetState.ds());

  List<StoryItem> _addStoryItems(User user) {
    final storyItems = <StoryItem>[];
    for (final story in user.stories) {
      switch (story.mediaType) {
        case MediaType.image:
          storyItems.add(
            StoryItem.pageImage(
              url: story.url,
              controller: state.controller,
              caption: story.caption,
              duration: Duration(
                milliseconds: (story.duration * 1000).toInt(),
              ),
            ),
          );
          break;
        case MediaType.text:
          storyItems.add(
            StoryItem.text(
              title: story.caption,
              backgroundColor: story.color,
              duration: Duration(
                milliseconds: (story.duration * 1000).toInt(),
              ),
            ),
          );
          break;
      }
    }
    return storyItems;
  }

  void handleOnStoryShow(User user, int index) {
    emit(state.copyWith(
      date: user.stories[index].date,
      storyId: user.stories[index].id,
      indexStory: index,
    ));
  }

  void initState(User user) {
    final storyItems = _addStoryItems(user);
    String date = user.stories[0].date;
    String storyId = user.stories[0].id;
    emit(state.copyWith(
      date: date,
      storyId: storyId,
      storyItems: storyItems,
    ));
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
