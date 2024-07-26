import 'package:fudo_flutter/src/core/config/local_db/hive_config.dart';
import 'package:fudo_flutter/src/core/config/network/api_exception.dart';
import 'package:fudo_flutter/src/core/config/network/api_service.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/domain/repositories/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository_impl.g.dart';

@riverpod
PostRepository postsRepositoryImp(PostsRepositoryImpRef ref) =>
    PostRepositoryImpl(
      api: ApiServiceImpl(),
      localStorage: HiveConfig.instance,
    );

class PostRepositoryImpl implements PostRepository {
  final ApiService api;
  final HiveConfig localStorage;

  PostRepositoryImpl({
    required this.api,
    required this.localStorage,
  });

  @override
  Future<PostEntity> createRandomPost(PostEntity post) async {
    try {
      // network
      final (error, response) =
          await api.post<Map<String, dynamic>>('posts', data: post.toJson());

      if (error != null) throw error;

      // convert
      final PostEntity fetchedPost = PostEntity.fromJson(response.data!);

      return fetchedPost;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      // load from network
      final (error, response) = await api.get<List<dynamic>>('posts');

      if ((error is NoConnectionException || error is TimeOutException) &&
          localStorage.postBox.get().isNotEmpty) {
        return localStorage.postBox.get();
      } else if (response.data?.isEmpty ?? true) {
        throw ApiException(message: 'No posts found', code: '404');
      } else if (error != null) {
        throw error;
      }
      // convert
      final List<PostEntity> fetchedList = List<PostEntity>.from(
          response.data!.map((e) => PostEntity.fromJson(e)));

      // save to local storage
      await localStorage.postBox.set(fetchedList);

      return fetchedList;
    } catch (_) {
      rethrow;
    }
  }
}
