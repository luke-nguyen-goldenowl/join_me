import 'package:flutter/material.dart';
import 'package:myapp/src/router/route_name.dart';

enum XNavigationBarItems {
  home(
    label: 'Home',
    route: AppRouteNames.home,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  event(
    label: 'Event',
    route: AppRouteNames.event,
    icon: Icons.calendar_today_outlined,
    selectedIcon: Icons.calendar_month_sharp,
  ),
  followed(
    label: 'Followed',
    route: AppRouteNames.followed,
    icon: Icons.local_activity_outlined,
    selectedIcon: Icons.local_activity,
  ),
  manageEvent(
    label: 'Manage',
    route: AppRouteNames.manageEvent,
    icon: Icons.dns_outlined,
    selectedIcon: Icons.dns_rounded,
  ),
  // account(
  //   label: 'Account',
  //   route: AppRouteNames.account,
  //   icon: Icons.people_outline,
  //   selectedIcon: Icons.people,
  // ),
  ;

  const XNavigationBarItems({
    required this.label,
    required this.route,
    required this.icon,
    this.selectedIcon,
  });

  final String label;
  final AppRouteNames route;
  final IconData icon;
  final IconData? selectedIcon;

  static XNavigationBarItems fromLocation(String location) {
    if (location == XNavigationBarItems.home.route.name) {
      return XNavigationBarItems.home;
    }

    return XNavigationBarItems.home;
  }
}
