import 'package:exams/features/exam/domain/entities/subject_entity.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/pages/main_page.dart';
import 'package:exams/features/exam/presentation/pages/subject_details_page.dart';
import 'package:exams/features/exam/presentation/pages/taps/explore_page.dart';
import 'package:exams/features/profile/presentation/pages/profile_page.dart';
import 'package:exams/features/results/presentation/pages/results_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/di.dart';
import '../../features/auth/presentation/pages/forget_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/exam/presentation/cubit/exams_event.dart';
import 'route_names.dart';
import 'route_paths.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.explore,
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
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => getIt<ExamsCubit>()..doEvent(GetSubjectsEvent()),
          child: MainPage(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: RoutePaths.explore,
          builder: (_, _) => const ExplorePage(),
        ),

        GoRoute(
          path: RoutePaths.subjectDetails,
          builder: (context, state) {
            final subject = state.extra as SubjectEntity;

            return SubjectDetailsPage(
              subject: subject,
            );
          },
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