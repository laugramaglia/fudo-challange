// final example =  {
//     "userId": 1,
//     "id": 3,
//     "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
//     "body": "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
//   };

import 'package:hive_flutter/hive_flutter.dart';

part 'post_entity.g.dart';

const int postEntityAdapterId = 0;

@HiveType(typeId: postEntityAdapterId)
class PostEntity extends HiveObject {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String body;

  PostEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..["userId"] = userId
    ..["title"] = title
    ..["body"] = body;

  @override
  String toString() =>
      'PostEntity(userId: $userId, id: $id, title: $title, body: $body)';

  @override
  int get hashCode =>
      userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          id == other.id &&
          title == other.title &&
          body == other.body;
}
