import 'package:hive/hive.dart';
part 'story.g.dart';

@HiveType(typeId: 0)
class Story extends HiveObject {
  @HiveField(0)
  String? username;

  @HiveField(1)
  final String content;

  Story({required this.content});
}

