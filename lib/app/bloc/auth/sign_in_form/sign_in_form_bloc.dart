import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:ddd_flutter_structure/code/core/failure/service_failure/remote/auth_failures.dart';
import 'package:ddd_flutter_structure/code/core/i_services_facade/remote/i_auth_facade.dart';
import 'package:ddd_flutter_structure/code/core/value_object/auth_v_objs.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(
    this._authFacade,
  ) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          email: EmailAddress(e.email),
          authFailOrNotOpt: none(),
        );
      },
      pwdChanged: (e) async* {
        yield state.copyWith(
          pwd: Password(e.pwd),
          authFailOrNotOpt: none(),
        );
      },
      registerWithEmailAndPwd: (e) async* {
        yield* _performActionWithEmailAndPwd(
          _authFacade.registerWithEmailAndPwd,
        );
      },
      signInWithEmailAndPwd: (e) async* {
        yield* _performActionWithEmailAndPwd(
          _authFacade.signInWithEmailAndPwd,
        );
      },
      signInWithGoogle: (e) async* {
        Either<AuthFailure, Unit> failureOrSuccess;
        yield state.copyWith(
          isSubmitting: true,
          authFailOrNotOpt: none(),
        );
        failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailOrNotOpt: some(failureOrSuccess),
        );
      },
    );
  }

  // ignore: slash_for_doc_comments
  /**
   * A PRIVATE FUNCTION TO PERFORM MULTIPLE SAME INFRASTRUCTURE REQUEST
   * (Very Interesting [FORWARDEDCALL])
   */
  Stream<SignInFormState> _performActionWithEmailAndPwd(
    Future<Either<AuthFailure, Unit>> Function({
      @required EmailAddress email,
      @required Password pwd,
    })
        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.pwd.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailOrNotOpt: none(),
      );

      failureOrSuccess = await forwardedCall(
        email: state.email,
        pwd: state.pwd,
      );
    }
    /**
     * NB: 
     * [optionOf(failOrSuccess) => (failOrSuccess== null ? none() : some(failOrSuccess))]
     */
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessage: true,
      authFailOrNotOpt: optionOf(failureOrSuccess),
    );
  }
}
