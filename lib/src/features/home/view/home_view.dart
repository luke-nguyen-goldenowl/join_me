import 'package:flutter/material.dart';
// import 'package:myapp/src/_dev/widget/dev_wrap_button.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/button/text_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButton(
          onPressed: () {
            AppCoordinator.showAccountScreen();
          },
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset("assets/images/images/avatar.png"),
          ),
          iconSize: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppCoordinator.showSearchScreen();
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCoordinator.showNotifyScreen();
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      // AppBar(
      //   title: const DevWrapButton(child: Text('Welcome')),
      // ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            XTextButton(
              title: 'Show Toast',
              onPressed: () {
                XToast.show('Clicked');
              },
            ),
            const XTextButton(
              title: 'Show sample view',
              onPressed: AppCoordinator.showSampleScreen,
            ),
          ],
        ),
      ),
    );
  }
}
