import 'dart:convert';

import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:test/test.dart';

import '../../../../../fixtures/reader.dart';

void main() {
  group('fromJson', () {
    test('should return a PostEntity', () {
      final Map<String, dynamic> json =
          jsonDecode(fixtureReader('single_post.json'));

      final result = PostEntity.fromJson(json);

      expect(result, isA<PostEntity>());
    });
  });

  group('toJson', () {
    test('should return a Map<String, dynamic>', () {
      final PostEntity post = PostEntity(
        userId: 1,
        id: 1,
        title: 'title',
        body: 'body',
      );

      final result = post.toJson();

      expect(result, isA<Map<String, dynamic>>());
    });
  });
}
