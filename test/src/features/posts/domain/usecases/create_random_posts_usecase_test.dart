import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/create_random_post_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../repositories/post_repository_test.mocks.dart';

void main() {
  late MockPostRepository mockPostRepository;
  late CreateRandomPostsUsecase usecase;
  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = CreateRandomPostsUsecase(repository: mockPostRepository);
  });

  group('CreateRandomPostsUsecase', () {
    final tPost = PostEntity(
      userId: 1,
      id: 1,
      title: 'title',
      body: 'body',
    );

    test('should return a post', () async {
      when(mockPostRepository.createRandomPost(tPost))
          .thenAnswer((_) async => tPost);

      final result = await usecase.call(tPost);

      expect(result, tPost);
      verify(mockPostRepository.createRandomPost(tPost));
      verifyNoMoreInteractions(mockPostRepository);
    });
  });
}
