import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:fudo_flutter/src/features/posts/presentation/providers/get_posts_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../riverpod_container.dart';

import 'get_posts_provider_test.mocks.dart';

@GenerateMocks([GetPostsUsecase])
void main() {
  late MockGetPostsUsecase mockGetPostsUsecase;

  setUp(() {
    mockGetPostsUsecase = MockGetPostsUsecase();
  });

  test('build returns a list of posts', () async {
    // Arrange
    final container = createContainer(overrides: [
      getPostsUsecaseProvider.overrideWith((ref) => mockGetPostsUsecase),
    ]);
    final mockPosts = [
      PostEntity(userId: 1, id: 1, title: 'Post 1', body: 'Content 1'),
      PostEntity(userId: 2, id: 2, title: 'Post 2', body: 'Content 2'),
    ];

    when(mockGetPostsUsecase.call()).thenAnswer((_) => Future.value(mockPosts));

    // Act
    final result = await container.read(getPostsProvider.future);

    // Assert
    expect(result, mockPosts);
    verify(mockGetPostsUsecase.call());
    verifyNoMoreInteractions(mockGetPostsUsecase);
  });

  test('addPost adds a post to the list', () async {
    // Arrange
    final container = createContainer(overrides: [
      getPostsUsecaseProvider.overrideWith((ref) => mockGetPostsUsecase),
    ]);

    // mock data

    when(mockGetPostsUsecase.call()).thenAnswer((_) => Future.value([]));
    final notifier = container.read(getPostsProvider.notifier);
    await notifier.build();

    final postToAdd =
        PostEntity(userId: 4, id: 4, title: 'Post 4', body: 'Content Z');

    // Act
    notifier.addPost(postToAdd);

    // Assert
    expect(container.read(getPostsProvider).value, [postToAdd]);
    verify(mockGetPostsUsecase.call());
    verifyNoMoreInteractions(mockGetPostsUsecase);
  });

  test('filter posts by userId', () async {
    // Arrange
    final container = createContainer(overrides: [
      getPostsUsecaseProvider.overrideWith((ref) => mockGetPostsUsecase),
    ]);
    final mockPosts = [
      PostEntity(userId: 1, id: 1, title: 'Post 1', body: 'Content 1'),
      PostEntity(userId: 2, id: 2, title: 'Post 2', body: 'Content 2'),
    ];
    when(mockGetPostsUsecase.call()).thenAnswer((_) => Future.value(mockPosts));

    final notifier = container.read(getPostsProvider.notifier);
    await notifier.build(); // Initialize the notifier

    // Act
    notifier.filter(1);

    // Assert
    expect(container.read(getPostsProvider).value, [mockPosts.first]);
    verify(mockGetPostsUsecase.call());
    verifyNoMoreInteractions(mockGetPostsUsecase);
  });

  test('filter with null query returns all posts', () async {
    // Arrange
    final container = createContainer(overrides: [
      getPostsUsecaseProvider.overrideWith((ref) => mockGetPostsUsecase),
    ]);
    final mockPosts = [
      PostEntity(userId: 1, id: 1, title: 'Post 1', body: 'Content 1'),
      PostEntity(userId: 2, id: 2, title: 'Post 2', body: 'Content 2'),
    ];
    when(mockGetPostsUsecase.call()).thenAnswer((_) => Future.value(mockPosts));

    final notifier = container.read(getPostsProvider.notifier);
    await notifier.build(); // Initialize the notifier

    // Act
    notifier.filter(null);

    // Assert
    expect(container.read(getPostsProvider).value, mockPosts);
    verify(mockGetPostsUsecase.call());
    verifyNoMoreInteractions(mockGetPostsUsecase);
  });
}
