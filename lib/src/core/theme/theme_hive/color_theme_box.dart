import 'package:hive_flutter/hive_flutter.dart';

class ColorThemeBox {
  // crerate singelton instance
  static final ColorThemeBox instance = ColorThemeBox._();
  ColorThemeBox._();

  late final Box<String> _box;

  final String hiveBoxName = 'color_theme_box';
  Future<void> init() async {
    _box = await Hive.openBox<String>(hiveBoxName);
  }

  // update
  Future<void> set(String key, String value) async =>
      await _box.put(key, value);

  // get value from key
  String? get(String key) => _box.get(key);

  Future<void> clear() async => await _box.clear();
}
