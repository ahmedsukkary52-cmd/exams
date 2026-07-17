import 'package:exams/core/routing/route_names.dart';
import 'package:exams/core/theme/theme_app.dart';
import 'package:exams/features/auth/presentation/login/cubit/sign_in_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/validators/validators_app.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../domain/entites/request/sign_in_request.dart';
import '../cubit/sign_in_event.dart';
import '../cubit/sign_in_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SignInCubit cubit = getIt();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onFormChanged() {
    cubit.doIntent(SignInFormChanged(_isFormFilled));
  }

  bool get _isFormFilled {
    return emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onFormChanged);
    passwordController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    emailController.removeListener(_onFormChanged);
    passwordController.removeListener(_onFormChanged);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          switch (state.auth.status) {
            case Status.success:
              context.goNamed(RouteNames.explore);
              break;
            case Status.error:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.auth.message ?? "Something went wrong"),
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
              title: Text('Login', style: ThemeApp.text.medium20black),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  spacing: 24.h,
                  children: [
                    AppTextFormField(
                      controller: emailController,
                      label: "Email",
                      hint: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidatorsApp.validateEmail,
                    ),
                    AppTextFormField(
                      controller: passwordController,
                      label: "Password",
                      hint: "Enter password",
                      isPassword: true,
                      validator: ValidatorsApp.validatePassword,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeApp.colors.primary,
                          value: state.rememberMe,
                          onChanged: (value) {
                            cubit.doIntent(RememberMeChanged(value ?? false));
                          },
                        ),
                        Text(
                          'Remember Me',
                          style: ThemeApp.text.regular13black,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(RouteNames.forgetPassword);
                          },
                          child: Text(
                            'Forget Password?',
                            style: ThemeApp.text.regular12black.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(),
                    Column(
                      children: [
                        AppElevatedButton(
                          isLoading: state.auth.status == Status.loading,
                          onPressed:
                              !state.isFormValid ||
                                  state.auth.status == Status.loading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  final request = SignInRequest(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                  );

                                  cubit.doIntent(SignInPressed(request));
                                },
                          text: "Login",
                        ),
                        SizedBox(height: 16.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: ThemeApp.text.regular16black,
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style: ThemeApp.text.medium16blue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.go(RouteNames.explore),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
