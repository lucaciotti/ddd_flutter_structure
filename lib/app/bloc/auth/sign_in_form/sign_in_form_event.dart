part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String email) = _EmailChanged;
  const factory SignInFormEvent.pwdChanged(String pwd) = _PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPwd() =
      _RegisterWithEmailAndPwd;
  const factory SignInFormEvent.signInWithEmailAndPwd() =
      _SignInWithEmailAndPwd;
  const factory SignInFormEvent.signInWithGoogle() = _SignInWithGoogle;
}
