import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/create_random_post_usecase.dart';
import 'package:fudo_flutter/src/features/posts/presentation/providers/create_random_post_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../riverpod_container.dart';
import 'create_random_post_provide_test.mocks.dart';

@GenerateMocks([CreateRandomPostsUsecase])
void main() {
  late MockCreateRandomPostsUsecase mockCreateRandomPostsUsecase;

  setUp(() {
    mockCreateRandomPostsUsecase = MockCreateRandomPostsUsecase();
  });

  test('createRandomPost returns a newly created post', () async {
    // Arrange
    final container = createContainer(overrides: [
      createRandomPostsUsecaseProvider
          .overrideWith((ref) => mockCreateRandomPostsUsecase),
    ]);
    final inputPost =
        PostEntity(userId: 1, id: 0, title: 'New Post', body: 'Random content');

    final responsePost = PostEntity(
        userId: 1, id: 10, title: 'New Post', body: 'Random content');

    when(mockCreateRandomPostsUsecase.call(inputPost))
        .thenAnswer((_) async => responsePost);

    // Act
    final result =
        await container.read(createRandomPostProvider(inputPost).future);

    // Assert
    expect(result, responsePost);
    verify(mockCreateRandomPostsUsecase.call(inputPost)).called(1);
    verifyNoMoreInteractions(mockCreateRandomPostsUsecase);
  });
}
