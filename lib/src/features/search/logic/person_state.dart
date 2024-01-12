// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/user/user.dart';

class PersonState {
  MUser person;
  PersonState({
    required this.person,
  });

  PersonState copyWith({
    MUser? person,
  }) {
    return PersonState(
      person: person ?? this.person,
    );
  }
}
