import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:ddd_flutter_structure/code/core/entity/auth/user.dart';
import 'package:ddd_flutter_structure/code/core/failure/service_failure/remote/auth_failures.dart';
import 'package:ddd_flutter_structure/code/core/value_object/auth_v_objs.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPwd({
    @required EmailAddress email,
    @required Password pwd,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPwd({
    @required EmailAddress email,
    @required Password pwd,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
