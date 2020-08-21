import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ddd_flutter_structure/app/bloc/auth/auth_bloc.dart';
import 'package:ddd_flutter_structure/code/injectable/injection.dart';
import 'package:ddd_flutter_structure/ui/routes/router.gr.dart';
import 'package:ddd_flutter_structure/ui/theme/style.dart';

// ignore: slash_for_doc_comments
/**
 * Here there are NOT the views but just the overall AppUI Configuration
 */

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(
              const AuthEvent.authCheck(),
            ), //Let's check immediatly if user it's loggedIn
        ),
      ],
      child: MaterialApp(
        title: 'ToDDDoApp',
        debugShowCheckedModeBanner: false,
        theme: appTheme(context),
        builder: ExtendedNavigator(
          router: Router(),
        ),
        // home: const SignInPage(),
      ),
    );
  }
}
