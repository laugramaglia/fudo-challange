import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/create_random_post_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_random_post_provider.g.dart';

@riverpod
Future<PostEntity> createRandomPost(
    CreateRandomPostRef ref, PostEntity post) async {
  final response = await ref.read(createRandomPostsUsecaseProvider).call(post);
  return response;
}
