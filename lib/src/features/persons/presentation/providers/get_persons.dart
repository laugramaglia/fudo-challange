import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:fudo_flutter/src/features/persons/domain/usecases/get_persons_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_persons.g.dart';

@riverpod
Future<List<PersonEntity>> getPersons(GetPersonsRef ref) async {
  final response = await ref.read(getPersonsUsecaseProvider).call();

  ref.keepAlive();
  return response;
}
