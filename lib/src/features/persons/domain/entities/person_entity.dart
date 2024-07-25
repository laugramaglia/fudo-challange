// final example = {
//   "id": 1,
//   "name": "Leanne Graham",
//   "username": "Bret",
//   "email": "Sincere@april.biz",
//   "address": {
//     "street": "Kulas Light",
//     "suite": "Apt. 556",
//     "city": "Gwenborough",
//     "zipcode": "92998-3874",
//     "geo": {"lat": "-37.3159", "lng": "81.1496"}
//   }
// };
// avoid sensitive data

import 'package:hive_flutter/hive_flutter.dart';

part 'person_entity.g.dart';

@HiveType(typeId: 1)
class PersonEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;

  PersonEntity({
    required this.id,
    required this.name,
    required this.username,
  });

  factory PersonEntity.fromJson(Map<String, dynamic> json) {
    return PersonEntity(
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }

  @override
  String toString() => 'UsersEntity(id: $id, name: $name, username: $username)';
}
