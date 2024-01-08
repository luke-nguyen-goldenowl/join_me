import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:story_view/story_view.dart';

class StoryWidgetBloc extends Cubit<StoryWidgetState> {
  StoryWidgetBloc() : super(StoryWidgetState.ds());
  StoryController controller = StoryController();
  DomainManager domain = DomainManager();

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

  void handleOnStoryShow(List<MStory> stories, int index) async {
    try {
      final user = GetIt.I<AccountBloc>().state.user;
      final result = await domain.story
          .updateViewerStory(stories[index].id ?? "", user.id);

      if (result.isSuccess) {
        final userStory = GetIt.I<HomeBloc>().state.userStory;

        final indexUser =
            userStory.indexWhere((element) => element.user.id == state.host.id);
        GetIt.I<HomeBloc>().handleSeenStory(indexUser, index);
        emit(state.copyWith(
          date: DateHelper.getFormatStoryTime(stories[index].time),
          storyId: stories[index].id,
          indexStory: index,
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  void initState(List<MStory> stories, MUser host) {
    final storyItems = _addStoryItems(stories);
    String date = DateHelper.getFormatStoryTime(stories[0].time);
    // String storyId = user.stories[0].id;
    emit(state.copyWith(
      date: date,
      // storyId: storyId,
      host: host,
      storyItems: storyItems,
    ));
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
