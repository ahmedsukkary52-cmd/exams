import 'package:exams/core/routing/route_names.dart';
import 'package:exams/core/theme/theme_app.dart';
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
import '../../../domain/entites/request/signup_request.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_events.dart';
import '../cubit/signup_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupCubit cubit = getIt();

  final _formKey = GlobalKey<FormState>();
  late final List<TextEditingController> _controllers;

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _onFormChanged() {
    cubit.doIntent(SignupFormChanged(_isFormFilled));
  }

  @override
  void initState() {
    super.initState();

    _controllers = [
      userNameController,
      firstNameController,
      lastNameController,
      emailController,
      phoneController,
      passwordController,
      confirmPasswordController,
    ];

    for (final controller in _controllers) {
      controller.addListener(_onFormChanged);
    }
  }

  bool get _isFormFilled {
    return userNameController.text.trim().isNotEmpty &&
        firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_onFormChanged);
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          switch (state.signup.status) {
            case Status.success:
              context.push(RouteNames.explore);
              break;
            case Status.error:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.signup.message ?? "Something went wrong"),
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
              title: Text('Sign Up', style: ThemeApp.text.medium20black),
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
                      controller: userNameController,
                      label: "User Name",
                      hint: "Enter your user name",
                      validator: ValidatorsApp.validateUserName,
                    ),

                    Row(
                      spacing: 18.w,
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            controller: firstNameController,
                            label: "First Name",
                            hint: "Enter first name",
                            validator: ValidatorsApp.validateFirstName,
                          ),
                        ),
                        Expanded(
                          child: AppTextFormField(
                            controller: lastNameController,
                            label: "Last Name",
                            hint: "Enter last name",
                            validator: ValidatorsApp.validateLastName,
                          ),
                        ),
                      ],
                    ),

                    AppTextFormField(
                      controller: emailController,
                      label: "Email",
                      hint: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidatorsApp.validateEmail,
                    ),
                    Row(
                      spacing: 18.w,
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            controller: passwordController,
                            label: "Password",
                            hint: "Enter password",
                            isPassword: true,
                            validator: ValidatorsApp.validatePassword,
                          ),
                        ),
                        Expanded(
                          child: AppTextFormField(
                            controller: confirmPasswordController,
                            label: "Confirm Password",
                            hint: "Confirm password",
                            isPassword: true,
                            validator: (value) {
                              return ValidatorsApp.validateConfirmPassword(
                                value,
                                passwordController.text,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppTextFormField(
                      controller: phoneController,
                      label: "Phone",
                      hint: "Enter your phone",
                      keyboardType: TextInputType.phone,
                      validator: ValidatorsApp.validatePhoneNumber,
                    ),

                    SizedBox(),
                    Column(
                      children: [
                        AppElevatedButton(
                          isLoading: state.signup.status == Status.loading,
                          onPressed:
                              !state.isFormValid ||
                                  state.signup.status == Status.loading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  final request = SignupRequest(
                                    username: userNameController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    password: passwordController.text,
                                    rePassword: confirmPasswordController.text,
                                  );

                                  cubit.doIntent(SignupPressed(request));
                                },
                          text: "Sign Up",
                        ),
                        SizedBox(height: 16.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: ThemeApp.text.regular16black,
                              ),
                              TextSpan(
                                text: "Login",
                                style: ThemeApp.text.medium16blue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.push(RouteNames.explore),
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
