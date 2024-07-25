import 'package:fudo_flutter/src/features/posts/data/post_repository_impl.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/repositories/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_random_post_usecase.g.dart';

@riverpod
CreateRandomPostsUsecase createRandomPostsUsecase(
        CreateRandomPostsUsecaseRef ref) =>
    CreateRandomPostsUsecase(repository: ref.read(postsRepositoryImpProvider));

class CreateRandomPostsUsecase {
  final PostRepository repository;

  CreateRandomPostsUsecase({required this.repository});

  Future<PostEntity> call(PostEntity post) async =>
      await repository.createRandomPost(post);
}
