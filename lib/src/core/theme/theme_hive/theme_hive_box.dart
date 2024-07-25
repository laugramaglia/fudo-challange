import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeBox {
  // crerate singelton instance
  static final ThemeBox instance = ThemeBox._();
  ThemeBox._();

  late final Box<String> _box;

  final String _hiveBoxName = 'theme_box';
  final String _key = 'theme-mode';
  Future<void> init() async {
    _box = await Hive.openBox<String>(_hiveBoxName);
  }

  // lstenable
  ValueListenable<Box<String>> listenable() => _box.listenable();

  // update
  Future<void> set(String value) async => await _box.put(_key, value);

  // get value from key
  String? get() => _box.get(_key);

  Future<void> clear() async => await _box.clear();
}
