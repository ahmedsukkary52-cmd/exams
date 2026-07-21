import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/theme/theme_app.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.child,
  });

  final Widget child;

  Future<void> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ThemeApp.colors.whiteColor,
        title: Text(
          'Exit App',
          style: ThemeApp.text.medium20black,
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: ThemeApp.text.regular16black,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ThemeApp.colors.primary,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    if (shouldExit == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    final selectedIndex = switch (location) {
      RoutePaths.explore => 0,
      RoutePaths.results => 1,
      RoutePaths.profile => 2,
      _ => 0,
    };

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if(didPop) return;
        await _showExitDialog(context);
      },
      child: Scaffold(
        body: child,
        backgroundColor: ThemeApp.colors.whiteColor,
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            height: 82.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: ThemeApp.colors.whiteColor,
                indicatorColor: const Color(0xFFDCE8FF),
                iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
                    size: 24.sp,
                    color: ThemeApp.colors.primary,
                  ),
                ),
                labelTextStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ThemeApp.colors.primary,
                  ),
                ),
              ),
              child: NavigationBar(
                height: 82.h,
                backgroundColor: ThemeApp.colors.whiteColor,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                selectedIndex: selectedIndex,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: (index) {
                  switch (index) {
                    case 0:
                      context.go(RoutePaths.explore);
                      break;

                    case 1:
                      context.go(RoutePaths.results);
                      break;

                    case 2:
                      context.go(RoutePaths.profile);
                      break;
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded),
                    label: 'Explore',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.assignment_outlined),
                    selectedIcon: Icon(Icons.assignment_rounded),
                    label: 'Result',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}