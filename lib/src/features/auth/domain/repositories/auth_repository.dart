import 'package:fudo_flutter/src/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInEmail(({String email, String password}) authData);
}
