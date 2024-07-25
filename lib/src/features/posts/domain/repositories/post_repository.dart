import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();

  Future<PostEntity> createRandomPost(PostEntity post);
}
