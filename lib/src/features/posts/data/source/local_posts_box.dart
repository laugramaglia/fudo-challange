import 'dart:async';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalPostsBox {
  // crerate singelton instance
  static final LocalPostsBox instance = LocalPostsBox._();
  LocalPostsBox._();

  late final Box<PostEntity> _box;

  final String _hiveBoxName = 'posts_box';
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(postEntityAdapterId)) {
      Hive.registerAdapter(PostEntityAdapter());
    }

    if (!Hive.isBoxOpen(_hiveBoxName)) {
      _box = await Hive.openBox<PostEntity>(_hiveBoxName);
    }
  }

  // update
  Future<int> add(PostEntity value) async => await _box.add(value);

  Future set(List<PostEntity> values) async =>
      await _box.clear().then((_) async {
        await _box.addAll(values);
      });

  // get value from key
  List<PostEntity> get() => List<PostEntity>.from(_box.values);

  Future<void> clear() async => await _box.clear();
}
