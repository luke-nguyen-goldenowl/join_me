import 'package:myapp/src/features/home/model/story.dart';

class User {
  final String id;
  final String name;
  final String imgUrl;
  final List<Story> stories;

  const User({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.stories,
  });
}
