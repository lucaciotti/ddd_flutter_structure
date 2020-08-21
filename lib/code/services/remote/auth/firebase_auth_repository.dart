import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:ddd_flutter_structure/code/services/remote/utils/firebase_extension.dart';

import 'package:ddd_flutter_structure/code/core/entity/auth/user.dart';
import 'package:ddd_flutter_structure/code/core/failure/service_failure/remote/auth_failures.dart';
import 'package:ddd_flutter_structure/code/core/i_services_facade/remote/i_auth_facade.dart';
import 'package:ddd_flutter_structure/code/core/value_object/auth_v_objs.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthRepository implements IAuthFacade {
  final FirebaseAuth _fAuth;
  final GoogleSignIn _gSignIn;
  FirebaseAuthRepository(this._fAuth, this._gSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPwd(
      {EmailAddress email, Password pwd}) async {
    /**
     * Do a check on Valid Value here does not make sense.
     * If arrives here something 'FAIL' there an error for sure!
     * So just use the getOrCrash method!!
     */
    final String emailString = email.getOrCrash() as String;
    final String pwdString = pwd.getOrCrash() as String;
    try {
      // ignore: unused_local_variable
      final AuthResult _authResult =
          await _fAuth.createUserWithEmailAndPassword(
              email: emailString, password: pwdString);
      // FirebaseUser registeredUser = _authResult.user;
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPwd(
      {EmailAddress email, Password pwd}) async {
    final String emailString = email.getOrCrash() as String;
    final String pwdString = pwd.getOrCrash() as String;
    try {
      await _fAuth.signInWithEmailAndPassword(
        email: emailString,
        password: pwdString,
      );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPwd());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount _gSignInAccount = await _gSignIn.signIn();
      if (_gSignInAccount == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final GoogleSignInAuthentication _gAuth =
          await _gSignInAccount.authentication;
      final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
        accessToken: _gAuth.accessToken,
        idToken: _gAuth.idToken,
      );

      // ignore: unused_local_variable
      final AuthResult _authResult =
          await _fAuth.signInWithCredential(_authCredential);
      // final User registeredUser = _authResult.user;
      // print(_authResult.user);
      // print(await _gSignIn.isSignedIn());
      // print(await _fAuth.currentUser());
      return right(unit);
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  //--------------------------------------------------------------

  @override
  Future<Option<User>> getSignedInUser() => _fAuth
      .currentUser()
      .then((FirebaseUser fUser) => optionOf(fUser?.toEntity()));

  @override
  Future<void> signOut() {
    return Future.wait([
      _gSignIn.signOut(),
      _fAuth.signOut(),
    ]);
  }
}
