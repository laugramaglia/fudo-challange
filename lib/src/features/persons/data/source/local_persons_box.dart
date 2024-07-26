import 'dart:async';
import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalPersonsBox {
  // crerate singelton instance
  static final LocalPersonsBox instance = LocalPersonsBox._();
  LocalPersonsBox._();

  late final Box<PersonEntity> _box;

  final String _hiveBoxName = 'persons_box';
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(personEntityAdapterId)) {
      Hive.registerAdapter(PersonEntityAdapter());
    }
    if (!Hive.isBoxOpen(_hiveBoxName)) {
      _box = await Hive.openBox<PersonEntity>(_hiveBoxName);
    }
  }

  // update
  Future<int> add(PersonEntity value) async => await _box.add(value);

  Future set(List<PersonEntity> values) async =>
      await _box.clear().then((_) async {
        await _box.addAll(values);
      });

  // get value from key
  List<PersonEntity> get() => List<PersonEntity>.from(_box.values);

  Future<void> clear() async => await _box.clear();
}
