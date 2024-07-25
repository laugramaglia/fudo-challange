import 'package:fudo_flutter/src/features/persons/data/source/local_persons_box.dart';
import 'package:fudo_flutter/src/features/posts/data/source/local_posts_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  HiveConfig._();
  static final HiveConfig instance = HiveConfig._();

  // posts
  final LocalPostsBox postBox = LocalPostsBox.instance;

  // Persons
  final LocalPersonsBox personsBox = LocalPersonsBox.instance;

  Future<void> init() async {
    await Hive.initFlutter();
    await _start();
  }

  Future<void> _start() async {
    await Future.wait([
      // posts
      postBox.init(),

      // persons
      personsBox.init(),
    ]);
  }

  Future<void> clear() async {
    await Future.wait([
      // posts
      postBox.clear(),

      // persons
      personsBox.clear(),
    ]);
  }
}
