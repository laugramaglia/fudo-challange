import 'package:fudo_flutter/src/features/posts/domain/repositories/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'post_repository_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late final MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
  });
}
