import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/dashboard/logic/navigation_bar_item.dart';
import 'package:myapp/src/features/dashboard/logic/dashboard_bloc.dart';
import 'package:myapp/src/theme/colors.dart';

class XBottomNavigationBar extends StatelessWidget {
  const XBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, XNavigationBarItems>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.white,
          currentIndex: state.index,
          onTap: context.read<DashboardBloc>().onDestinationSelected,
          items: XNavigationBarItems.values
              .map((e) => BottomNavigationBarItem(
                    label: e.label,
                    icon: Icon(
                      e.icon,

                      // color: Colors.grey,
                    ),
                    activeIcon: Icon(e.selectedIcon),
                  ))
              .toList(),
          selectedItemColor: AppColors.rosyPink,
          unselectedItemColor: AppColors.grey,
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 25),
        );
      },
    );
  }
}

//  return NavigationBar(
//           backgroundColor: AppColors.white,
//           selectedIndex: state.index,
//           onDestinationSelected:
//               context.read<DashboardBloc>().onDestinationSelected,
//           destinations: XNavigationBarItems.values
//               .map((e) => NavigationDestination(
//                     label: e.label,
//                     icon: Icon(e.icon),
//                     selectedIcon: Icon(e.selectedIcon),
//                   ))
//               .toList(),
//         );
