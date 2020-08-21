import 'package:firebase_auth/firebase_auth.dart';

import 'package:ddd_flutter_structure/code/core/entity/auth/user.dart';
import 'package:ddd_flutter_structure/code/services/dtos/user_dtos.dart';

extension FirebaseUserX on FirebaseUser {
  User toEntity() {
    // ignore: avoid_print
    print(email);
    return UserDto.fromFirebaseAuth(this).toEntity();
  }
}
