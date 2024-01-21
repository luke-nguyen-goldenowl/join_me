enum AppRouteNames {
  home(path: '/'),
  dev(path: '/dev'),
  account(path: '/account'),
  signIn(path: '/sign-in'),
  signUp(path: '/sign-up'),
  forgotPassword(path: '/forgot'),
  sample(path: '/sample'),
  sampleDetails(
    path: 'sample-details',
    paramName: 'id',
  ),
  profile(path: '/profile'),
  editProfile(path: '/edit-profile'),
  settings(path: '/settings'),
  photoView(path: '/photoView'),

  event(path: '/event'),
  detailEvent(
    path: '/detail-event',
    paramName: 'id_event',
  ),
  addEvent(path: '/add-event'),
  followed(path: '/followed'),
  upcomingFollowed(path: '/upcoming'),
  pastFollowed(path: '/past'),
  manageEvent(path: '/manageEvent'),
  manageEventDetail(
    path: 'detail_manage_event',
    paramName: 'id_manage_event',
  ),
  editEvent(
    path: '/edit_event',
    // paramName: 'event_data',
  ),
  notify(path: '/notify'),
  profileOtherUser(
    path: '/profile_other_user',
    paramName: 'id_profile',
  ),
  search(path: '/search'),
  story(path: '/story'),
  addStory(path: '/add_story');

  const AppRouteNames({
    required this.path,
    this.paramName,
  });

  final String path;
  final String? paramName;

  String get name => path;

  String get subPath {
    if (path == '/') {
      return path;
    }
    return path.replaceFirst('/', '');
  }

  String get buildPathParam => '$path:$paramName';
  String get buildSubPathParam => '$subPath:$paramName';
}
