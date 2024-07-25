import 'package:fudo_flutter/src/features/posts/data/post_repository_impl.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/repositories/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_posts_usecase.g.dart';

@riverpod
GetPostsUsecase getPostsUsecase(GetPostsUsecaseRef ref) =>
    GetPostsUsecase(repository: ref.read(postsRepositoryImpProvider));

class GetPostsUsecase {
  final PostRepository repository;

  GetPostsUsecase({required this.repository});

  Future<List<PostEntity>> call() async => await repository.getPosts();
}
