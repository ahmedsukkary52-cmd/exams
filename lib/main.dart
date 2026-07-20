import 'package:exams/core/routing/app_router.dart';
import 'package:exams/core/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/di.dart';
import 'core/routing/route_paths.dart';
import 'core/storage/token_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final appPreferences = getIt<AppPreferences>();
  final tokenStorage = getIt<TokenStorage>();

  final rememberMe = await appPreferences.getRememberMe();
  final token = await tokenStorage.getAccessToken();

  final initialLocation = rememberMe && token != null
      ? RoutePaths.explore
    : RoutePaths.login;

  runApp(MyApp(initialLocation: initialLocation));
}

class MyApp extends StatelessWidget {
  final String initialLocation;

  const MyApp({super.key, this.initialLocation = RoutePaths.login});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter(RoutePaths.login),
        );
      },
    );
  }
}
