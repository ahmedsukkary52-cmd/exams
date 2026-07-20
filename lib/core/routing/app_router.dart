import 'package:exams/features/exam/domain/entities/exam_entity.dart';
import 'package:exams/features/exam/domain/entities/subject_entity.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_event.dart';
import 'package:exams/features/exam/presentation/pages/exam_details_page.dart';
import 'package:exams/features/exam/presentation/pages/main_page.dart';
import 'package:exams/features/exam/presentation/pages/subject_details_page.dart';
import 'package:exams/features/exam/presentation/pages/taps/explore_page.dart';
import 'package:exams/features/profile/presentation/pages/profile_page.dart';
import 'package:exams/features/results/presentation/pages/results_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/di.dart';
import '../../features/auth/presentation/email_verification/pages/email_verification.dart';
import '../../features/auth/presentation/forgot_password/pages/forget_password_page.dart';
import '../../features/auth/presentation/login/pages/login_page.dart';
import '../../features/auth/presentation/signup/pages/signup_page.dart';
import '../../features/exam/presentation/pages/exam_session_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

GoRouter appRouter(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        name: RouteNames.signup,
        path: RoutePaths.signup,
        builder: (_, __) => const SignupPage(),
      ),
      GoRoute(
        name: RouteNames.forgetPassword,
        path: RoutePaths.forgetPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: RouteNames.emailVerification,
        path: RoutePaths.emailVerification,
        builder: (_, __) => const EmailVerification(),
      ),
      GoRoute(
        name: RouteNames.examDetails,
        path: RoutePaths.examDetails,
        builder: (context, state) {
          final exam = state.extra as ExamEntity;
          return ExamDetailsPage(exam: exam);
        },
      ),
      GoRoute(
        name: RouteNames.examSession,
        path: RoutePaths.examSession,
        builder: (context, state) {
          return const ExamSessionPage();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => getIt<ExamsCubit>()..doEvent(GetSubjectsEvent()),
            child: MainPage(child: child),
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.explore,
            builder: (_, __) => const ExplorePage(),
          ),
          GoRoute(
            path: RoutePaths.subjectDetails,
            builder: (context, state) {
              final subject = state.extra as SubjectEntity;
              return SubjectDetailsPage(subject: subject);
            },
          ),
          GoRoute(
            path: RoutePaths.results,
            builder: (_, __) => const ResultsPage(),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (_, __) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}