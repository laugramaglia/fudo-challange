import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'serarch_history_provider.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  @override
  List<PersonEntity> build() {
    ref.keepAlive();
    return [];
  }

  void add(PersonEntity user) {
    if (state.any((e) => e.id == user.id)) return;
    state = [...state, user];
  }
}
