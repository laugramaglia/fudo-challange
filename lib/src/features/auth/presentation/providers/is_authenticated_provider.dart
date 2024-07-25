import 'package:fudo_flutter/src/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_authenticated_provider.g.dart';

@riverpod
class IsAuthenticated extends _$IsAuthenticated {
  UserEntity? _user;
  @override
  bool build() => _user != null;

  void setUser([UserEntity? user]) {
    _user = user;
    state = user != null;
  }
}
