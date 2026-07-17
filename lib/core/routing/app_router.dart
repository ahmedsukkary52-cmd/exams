import 'package:exams/features/exam/presentation/pages/main_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/forgot_password/pages/forget_password_page.dart';
import '../../features/auth/presentation/login/pages/login_page.dart';
import '../../features/auth/presentation/signup/pages/signup_page.dart';
import '../../features/exam/presentation/pages/taps/explore_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/results/presentation/pages/results_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

GoRouter appRouter(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        name: RouteNames.signup,
        path: RoutePaths.signup,
        builder: (context, state) => const SignupPage(),
      ),

      GoRoute(
        name: RouteNames.forgetPassword,
        path: RoutePaths.forgetPassword,
        builder: (context, state) => const ForgetPasswordPage(),
      ),

      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.explore,
            builder: (_, _) => const ExplorePage(),
          ),
          GoRoute(
            path: RoutePaths.results,
            builder: (_, _) => const ResultsPage(),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (_, _) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
