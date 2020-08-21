part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheck() = _AuthCheck;
  const factory AuthEvent.signedOut() = _SignedOut;
}
