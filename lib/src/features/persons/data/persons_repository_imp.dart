import 'package:fudo_flutter/src/core/config/local_db/hive_config.dart';
import 'package:fudo_flutter/src/core/config/network/api_exception.dart';
import 'package:fudo_flutter/src/core/config/network/api_service.dart';
import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:fudo_flutter/src/features/persons/domain/repositories/persons_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persons_repository_imp.g.dart';

@riverpod
PersonsRepository personsRepositoryImp(PersonsRepositoryImpRef ref) =>
    PersonsRepositoryImpl(
      api: ApiServiceImpl(),
      localStorage: HiveConfig.instance,
    );

class PersonsRepositoryImpl implements PersonsRepository {
  final ApiService api;
  final HiveConfig localStorage;

  PersonsRepositoryImpl({required this.api, required this.localStorage});

  @override
  Future<List<PersonEntity>> getUsers({int page = 0}) async {
    try {
      // load from network
      final (error, response) = await api.get<List<dynamic>>('users');

      if ((error is NoConnectionException || error is TimeOutException) &&
          localStorage.personsBox.get().isNotEmpty) {
        return localStorage.personsBox.get();
      } else if (response.data?.isEmpty ?? true) {
        throw ApiException(message: 'No users found', code: '404');
      } else if (error != null) {
        throw error;
      }

      // convert
      final List<PersonEntity> fetchedList = List<PersonEntity>.from(
          response.data!.map((e) => PersonEntity.fromJson(e)));

      // save to local storage
      await localStorage.personsBox.set(fetchedList);
      return fetchedList;
    } catch (_) {
      rethrow;
    }
  }
}
