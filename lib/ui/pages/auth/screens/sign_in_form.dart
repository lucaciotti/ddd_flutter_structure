import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ddd_flutter_structure/app/bloc/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:ddd_flutter_structure/ui/shared/buttons/round_raised_button.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailOrNotOpt.fold(
          () {},
          (either) {
            either.fold(
              (failure) {
                FlushbarHelper.createError(
                  message: failure.map(
                    // Use localized strings here in your apps
                    cancelledByUser: (_) => 'Cancelled',
                    serverError: (_) => 'Server error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPwd: (_) =>
                        'Invalid email and password combination',
                  ),
                ).show(context);
              },
              (_) {},
            );
          },
        );
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            autovalidate: state.showErrorMessage,
            child: ListView(
              padding: const EdgeInsets.all(30.0),
              children: <Widget>[
                const Text(
                  '👀',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) =>
                      context.bloc<SignInFormBloc>().state.email.value.fold(
                            (f) => f.maybeMap(
                              invalidEmail: (_) => 'Invalid email',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  // controller: passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.pwdChanged(value)),
                  validator: (_) =>
                      context.bloc<SignInFormBloc>().state.pwd.value.fold(
                            (f) => f.maybeMap(
                              unSecurePassword: (_) => 'Short password',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () => context
                            .bloc<SignInFormBloc>()
                            .add(const SignInFormEvent.signInWithEmailAndPwd()),
                        child: const Text('SIGN IN'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FlatButton(
                        onPressed: () => context.bloc<SignInFormBloc>().add(
                            const SignInFormEvent.registerWithEmailAndPwd()),
                        child: const Text('REGISTER'),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                RoundRaisedButton(
                  onPressedButton: () => context
                      .bloc<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGoogle()),
                  textButton: const Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // if (state.isSubmitting) ...[
                //   const SizedBox(height: 8),
                //   const LinearProgressIndicator(value: null),
                // ]
              ],
            ),
          ),
        );
      },
    );
  }
}
