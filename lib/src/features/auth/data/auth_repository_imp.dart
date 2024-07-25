import 'package:fudo_flutter/src/core/config/network/api_service.dart';
import 'package:fudo_flutter/src/features/auth/domain/entities/user_entity.dart';
import 'package:fudo_flutter/src/features/auth/domain/repositories/auth_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_imp.g.dart';

@riverpod
AuthRepository authRepositoryImp(AuthRepositoryImpRef ref) =>
    AuthRepositoryImpl(
      api: ApiServiceImpl(),
// localStorage:,
    );

class AuthRepositoryImpl implements AuthRepository {
  final ApiService api;
  // final LocalStorage localStorage;

  AuthRepositoryImpl({
    required this.api,
  }
      //  required this.localStorage,}
      );

  @override
  Future<UserEntity> signInEmail(
      ({String email, String password}) authData) async {
    try {
      // load from network
      final response = await kUsersDbCall(authData);

      return UserEntity.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> kUsersDbCall(
          ({String email, String password}) authData) async =>
      Future.delayed(
        const Duration(seconds: 2),
        () {
          if (!_kUsers.any((e) => e['email'] == authData.email)) {
            throw Exception('User not found');
          }
          if (!_kUsers.any((e) => e['password'] == authData.password)) {
            throw Exception('Wrong password');
          }
          return _kUsers
              .where((e) =>
                  e['email'] == authData.email &&
                  e['password'] == authData.password)
              .first;
        },
      );

  List<Map<String, dynamic>> get _kUsers => [
        {
          "id": 1,
          "email": 'challenge@fudo',
          "password": 'password',
          "name": 'Fudo Challenge user',
        }
      ];
}
