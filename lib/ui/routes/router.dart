import 'package:auto_route/auto_route_annotations.dart';
import 'package:ddd_flutter_structure/ui/pages/auth/sign_in_page.dart';
import 'package:ddd_flutter_structure/ui/pages/splash/splash_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    // MaterialRoute(page: NotesOverviewPage),
    // MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
class $Router {}
