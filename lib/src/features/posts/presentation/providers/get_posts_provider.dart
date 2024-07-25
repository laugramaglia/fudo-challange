import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_posts_provider.g.dart';

@riverpod
class GetPosts extends _$GetPosts {
  late List<PostEntity> _posts;
  int? _filter;
  @override
  Future<List<PostEntity>> build() async {
    try {
      final response = await ref.read(getPostsUsecaseProvider).call();

      _posts = response;
      ref.keepAlive();
      return _filterByQuery;
    } catch (e) {
      rethrow;
    }
  }

  void addPost(PostEntity post) {
    _posts.add(post);
    state = AsyncValue.data(_filterByQuery);
  }

  void filter([int? query]) {
    _filter = query;
    state = AsyncValue.data(_filterByQuery);
  }

  List<PostEntity> get _filterByQuery => _filter == null
      ? _posts
      : List<PostEntity>.from(
          _posts.where((post) => post.userId == _filter),
        );
}
