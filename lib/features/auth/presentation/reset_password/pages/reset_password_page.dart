import 'dart:async';

import 'package:exams/features/auth/presentation/widget/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../../../../core/validators/validators_app.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../domain/entities/request/reset_password_request.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_event.dart';
import '../cubit/reset_password_state.dart';
import '../cubit/reset_password_ui_event.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final ResetPasswordCubit cubit = getIt();

  late final StreamSubscription<ResetPasswordUiEvent> _subscription;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool get _isFormValid {
    return ValidatorsApp.validatePassword(passwordController.text) == null &&
        ValidatorsApp.validateConfirmPassword(
          confirmPasswordController.text,
          passwordController.text,
        ) ==
            null;
  }

  @override
  void initState() {
    super.initState();

    passwordController.addListener(_onFormChanged);
    confirmPasswordController.addListener(_onFormChanged);

    _subscription = cubit.uiEvents.listen((event) {
      switch (event) {
        case NavigateToLogin():
          context.goNamed(RouteNames.login);

        case ShowError():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(event.message)),
          );
      }
    });
  }

  void _onFormChanged() {
    cubit.doIntent(
      ResetPasswordFormChanged(_isFormValid),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();

    passwordController.removeListener(_onFormChanged);
    confirmPasswordController.removeListener(_onFormChanged);

    passwordController.dispose();
    confirmPasswordController.dispose();

    cubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = GoRouterState
        .of(context)
        .extra as String;

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Password",
                style: ThemeApp.text.medium20black,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 30.h,
              ),
              child: Column(
                children: [
                  AuthHeader(
                    title: "Reset Password",
                    description:
                    "Password must not be empty and must contain 6\ncharacters with upper case letter and one\nnumber at least",
                  ),

                  SizedBox(height: 32.h),

                  AppTextFormField(
                    controller: passwordController,
                    label: "New Password",
                    hint: "Enter New Password",
                    isPassword: true,
                    validator: ValidatorsApp.validatePassword,
                  ),

                  SizedBox(height: 24.h),

                  AppTextFormField(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    hint: "Confirm Password",
                    isPassword: true,
                    validator: (value) {
                      return ValidatorsApp.validateConfirmPassword(
                        value,
                        passwordController.text,
                      );
                    },
                  ),

                  SizedBox(height: 48.h),

                  AppElevatedButton(
                    text: "Continue",
                    isLoading:
                    state.resetPassword.status ==
                        ResourceStatus.loading,
                    onPressed: !state.isFormValid
                        ? null
                        : () {
                      cubit.doIntent(
                        ResetPasswordPressed(
                          ResetPasswordRequest(
                            email: email,
                            newPassword:
                            passwordController.text.trim(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
