import 'package:exams/core/routing/route_names.dart';
import 'package:exams/core/theme/theme_app.dart';
import 'package:exams/features/auth/presentation/widget/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/validators/validators_app.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../domain/entites/request/forgot_password_request.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_event.dart';
import '../cubit/forgot_password_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordCubit cubit = getIt();
  final emailController = TextEditingController();

  void _onFormChanged() {
    cubit.doIntent(ForgotPasswordFormChanged(_isFormValid));
  }

  bool get _isFormValid {
    return ValidatorsApp.validateEmail(emailController.text) == null;
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    emailController.removeListener(_onFormChanged);
    emailController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          switch (state.forgotPassword.status) {
            case Status.success:
              context.goNamed(RouteNames.emailVerification);
              break;
            case Status.error:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.forgotPassword.message ?? "Something went wrong",
                  ),
                ),
              );
              break;

            default:
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Password', style: ThemeApp.text.medium20black),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                children: [
                  AuthHeader(
                    title: 'Forget Password',
                    description:
                    'Please enter your email associated to\nyour account',
                  ),
                  SizedBox(height: 32.h,),
                  AppTextFormField(
                    controller: emailController,
                    label: "Email",
                    hint: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidatorsApp.validateEmail,
                  ),
                  SizedBox(height: 48.h),
                  AppElevatedButton(
                    isLoading: state.forgotPassword.status == Status.loading,
                    onPressed: !state.isFormValid ||
                        state.forgotPassword.status == Status.loading
                        ? null
                        : () {
                      final request = ForgotPasswordRequest(
                        email: emailController.text.trim(),
                      );

                      cubit.doIntent(ForgotPasswordPressed(request));
                    },
                    text: "Continue",
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
