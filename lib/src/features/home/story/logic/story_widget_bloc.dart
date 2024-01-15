import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:story_view/story_view.dart';

class StoryWidgetBloc extends Cubit<StoryWidgetState> {
  StoryWidgetBloc({required List<MStory> stories, required MUser host})
      : super(StoryWidgetState.ds()) {
    final storyItems = _addStoryItems(stories);
    String date = DateHelper.getFormatStoryTime(stories[0].time);
    emit(state.copyWith(
      date: date,
      host: host,
      storyItems: storyItems,
      stories: stories,
    ));
  }
  StoryController controller = StoryController();
  DomainManager domain = DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  List<StoryItem> _addStoryItems(List<MStory> stories) {
    final storyItems = <StoryItem>[];
    for (final story in stories) {
      storyItems.add(
        StoryItem.pageImage(
          url: story.image ?? "",
          controller: controller,
          duration: Duration(
            milliseconds: (5 * 1000).toInt(),
          ),
        ),
      );
    }

    return storyItems;
  }

  void handleOnStoryShow(
      List<MStory> stories,
      int index,
      Function(int, int) handleSeenStory,
      final List<MUserStory> userStory) async {
    try {
      final result = await domain.story
          .updateViewerStory(stories[index].id ?? "", user.id);

      if (result.isSuccess) {
        final indexUser =
            userStory.indexWhere((element) => element.user.id == state.host.id);
        handleSeenStory(indexUser, index);
        emit(state.copyWith(
          date: DateHelper.getFormatStoryTime(stories[index].time),
          indexStory: index,
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
