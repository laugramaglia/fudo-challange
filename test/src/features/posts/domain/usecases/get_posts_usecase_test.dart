import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../repositories/post_repository_test.mocks.dart';

void main() {
  late MockPostRepository mockPostRepository;
  late GetPostsUsecase usecase;
  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetPostsUsecase(repository: mockPostRepository);
  });

  group('GetPostsUsecase', () {
    final tPosts = [
      PostEntity(
        userId: 1,
        id: 1,
        title: 'title',
        body: 'body',
      )
    ];

    test('should return a list of posts', () async {
      when(mockPostRepository.getPosts()).thenAnswer((_) async => tPosts);

      final result = await usecase.call();

      expect(result, tPosts);
      verify(mockPostRepository.getPosts());
      verifyNoMoreInteractions(mockPostRepository);
    });
  });
}
