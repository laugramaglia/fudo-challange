import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_flutter/src/core/config/local_db/hive_config.dart';
import 'package:fudo_flutter/src/core/config/network/api_exception.dart';
import 'package:fudo_flutter/src/core/config/network/api_response.dart';
import 'package:fudo_flutter/src/core/config/network/api_service.dart';
import 'package:fudo_flutter/src/features/posts/data/post_repository_impl.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/reader.dart';

import 'post_repository_impl_test.mocks.dart';

Future<void> configLocalStorage() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testMockStorage = 'test/fixtures/hive/';
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          channel, (MethodCall methodCall) async => testMockStorage);
}

@GenerateMocks([ApiService])
void main() {
  late PostRepositoryImpl postRepositoryImpl;
  late MockApiService mockApiService;

  setUp(() async {
    await configLocalStorage();
    await HiveConfig.instance.init();
    mockApiService = MockApiService();
    postRepositoryImpl = PostRepositoryImpl(
      api: mockApiService,
      localStorage: HiveConfig.instance,
    );
  });

  group('Get Posts', () {
    test('should return a list of PostEntity', () async {
      // Arrange
      when(mockApiService.get<List<dynamic>>(any))
          .thenAnswer((_) async => Future.value(
                (
                  null,
                  ApiResponse<List<dynamic>>(
                    statusCode: 200,
                    data: jsonDecode(fixtureReader('list_posts.json')),
                  ),
                ),
              ));

      // Act
      final List<PostEntity> posts = await postRepositoryImpl.getPosts();

      // Assert
      expect(posts, isA<List<PostEntity>>());
      verify(mockApiService.get<List<dynamic>>(any));
      verifyNoMoreInteractions(mockApiService);
    });

    test('should return a exception', () async {
      // Arrange
      when(mockApiService.get<List<dynamic>>(any))
          .thenAnswer((_) async => Future.value(
                (
                  ApiException(message: 'Error', code: '500'),
                  ApiResponse<List<dynamic>>(
                    statusCode: 500,
                    data: jsonDecode(fixtureReader('list_posts.json')),
                  ),
                ),
              ));

      // Act
      final Future<List<PostEntity>> posts = postRepositoryImpl.getPosts();
      // Assert
      expect(() async => await posts, throwsA(isA<ApiException>()));
    });

    test('should return a list on Network error', () async {
      // Arrange
      when(mockApiService.get<List<dynamic>>(any))
          .thenAnswer((_) async => Future.value(
                (
                  NoConnectionException(),
                  ApiResponse<List<dynamic>>(
                    statusCode: 500,
                    data: jsonDecode(fixtureReader('list_posts.json')),
                  ),
                ),
              ));

      // Act
      final List<PostEntity> posts = await postRepositoryImpl.getPosts();

      // Assert
      expect(posts, isA<List<PostEntity>>());
    });
  });
}
