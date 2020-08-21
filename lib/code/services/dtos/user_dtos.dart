import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ddd_flutter_structure/code/core/entity/auth/user.dart';
import 'package:ddd_flutter_structure/code/core/value_object/auth_v_objs.dart';
import 'package:ddd_flutter_structure/code/core/value_object/common/string_v_objs.dart';
import 'package:ddd_flutter_structure/code/core/value_object/common/unique_id.dart';

part 'user_dtos.freezed.dart';
part 'user_dtos.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey() String uid,
    @required String name,
    @required String email,
  }) = _UserDto;

  factory UserDto.fromEntity(User user) {
    return UserDto(
      uid: user.uid.getOrCrash(),
      name: user.name.getOrElse(''),
      email: user.email.getOrCrash() as String,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromFirestore(DocumentSnapshot doc) {
    return UserDto.fromJson(doc.data).copyWith(uid: doc.documentID);
  }

  factory UserDto.fromFirebaseAuth(FirebaseUser fUser) {
    return UserDto(
      uid: fUser.uid,
      name: fUser.displayName ?? fUser.email.split('@').first,
      email: fUser.email,
    );
  }
}

extension UserDtoX on UserDto {
  User toEntity() {
    return User(
      uid: UniqueID.fromUniqueString(uid),
      name: StringSingleLine(name),
      email: EmailAddress(email),
    );
  }
}
