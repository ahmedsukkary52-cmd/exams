import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forget_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/exam/presentation/pages/exam_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/results/presentation/pages/results_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.login,
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

    GoRoute(
      name: RouteNames.profile,
      path: RoutePaths.profile,
      builder: (context, state) => const ProfilePage(),
    ),

    GoRoute(
      name: RouteNames.exam,
      path: RoutePaths.exam,
      builder: (context, state) => const ExamPage(),
    ),

    GoRoute(
      name: RouteNames.results,
      path: RoutePaths.results,
      builder: (context, state) => const ResultsPage(),
    ),
  ],
);
