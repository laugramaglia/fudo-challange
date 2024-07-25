import 'package:fudo_flutter/src/features/persons/data/persons_repository_imp.dart';
import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:fudo_flutter/src/features/persons/domain/repositories/persons_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_persons_usecase.g.dart';

@riverpod
GetPersonsUsecase getPersonsUsecase(GetPersonsUsecaseRef ref) =>
    GetPersonsUsecase(repository: ref.read(personsRepositoryImpProvider));

class GetPersonsUsecase {
  final PersonsRepository repository;

  GetPersonsUsecase({required this.repository});

  Future<List<PersonEntity>> call() async => await repository.getUsers();
}
