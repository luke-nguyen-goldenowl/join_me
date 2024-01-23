import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/localization/localization_utils.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';

class XDynamicLinks {
  static Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData.link);
    }).onError((error) {
      XToast.error(error.toString());
    });
  }

  static Future<String> buildShareEventLink({required MEvent event}) async {
    String url = "https://seejoy.page.link";
    Uri link = Uri.parse(url);
    SocialMetaTagParameters? metaData;
    metaData = SocialMetaTagParameters(
      title: "Join Us - Event ${event.name}",
      description: "Event: ${event.name}",
      imageUrl: Uri.parse(event.images != null && event.images![0].isNotEmpty
          ? event.images![0]
          : ""),
    );
    link = Uri.parse('$url/event/${event.id}');

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: link,
      androidParameters: const AndroidParameters(
        packageName: "com.keith.seejoy",
        minimumVersion: 0,
      ),
      socialMetaTagParameters: metaData,
    );
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl.toString();
  }

  static Future<void> handleDynamicLink(Uri url) async {
    if (url.isScheme("HTTPS")) {
      final domain = DomainManager();

      List<String> separatedString = [];
      separatedString.addAll(url.path.split('/'));

      final account = GetIt.I<AccountBloc>().state;

      if (separatedString.length == 3) {
        if (separatedString[1] == 'event') {
          if (account.isLogin) {
            var result = await domain.event.getEvent(separatedString[2]);
            if (result.isSuccess) {
              AppCoordinator.showEventDetails(id: result.data!.id ?? "");
            } else {
              XToast.error(result.error);
            }
          } else {
            XToast.error(S.text.please_log_in_as_crew_to_view_event_detail);
          }
        } else {
          XToast.error(S.text.error_no_content_to_show);
        }
      } else if (separatedString.length == 4) {
        AppCoordinator.showSignInScreen();
      } else {
        XToast.error(S.text.error_no_content_to_show);
      }
    } else {
      XToast.error(S.text.error_no_content_to_show);
    }
  }
}
