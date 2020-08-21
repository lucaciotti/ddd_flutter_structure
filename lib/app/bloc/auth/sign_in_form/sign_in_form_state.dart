part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required EmailAddress email,
    @required Password pwd,
    @required bool isSubmitting,
    @required bool showErrorMessage,
    @required Option<Either<AuthFailure, Unit>> authFailOrNotOpt,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        email: EmailAddress(''),
        pwd: Password(''),
        isSubmitting: false,
        showErrorMessage: false,
        authFailOrNotOpt: none(),
      );
}
