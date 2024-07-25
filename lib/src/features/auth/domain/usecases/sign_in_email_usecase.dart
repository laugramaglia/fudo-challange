import 'package:fudo_flutter/src/features/auth/data/auth_repository_imp.dart';
import 'package:fudo_flutter/src/features/auth/domain/entities/user_entity.dart';
import 'package:fudo_flutter/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_email_usecase.g.dart';

@riverpod
SignInEmailUsecase signInEmailUsecase(SignInEmailUsecaseRef ref) =>
    SignInEmailUsecase(repository: ref.read(authRepositoryImpProvider));

class SignInEmailUsecase {
  final AuthRepository repository;

  SignInEmailUsecase({required this.repository});

  Future<UserEntity> call(({String email, String password}) authData) async =>
      await repository.signInEmail(authData);
}
