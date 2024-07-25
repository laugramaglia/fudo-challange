import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';

abstract class PersonsRepository {
  Future<List<PersonEntity>> getUsers();
}
