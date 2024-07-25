import 'package:fudo_flutter/src/features/auth/domain/entities/user_entity.dart';
import 'package:fudo_flutter/src/features/auth/domain/usecases/sign_in_email_usecase.dart';
import 'package:fudo_flutter/src/features/auth/presentation/providers/is_authenticated_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_email_provider.g.dart';

@riverpod
Future<UserEntity?> signInEmail(SignInEmailRef ref,
    {required String email, required String password}) async {
  final response = await ref.read(signInEmailUsecaseProvider).call((
    email: email,
    password: password,
  ));

  ref.read(isAuthenticatedProvider.notifier).setUser(response);

  return response;
}
