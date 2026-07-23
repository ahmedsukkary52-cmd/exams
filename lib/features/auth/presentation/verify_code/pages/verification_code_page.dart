import 'package:exams/features/auth/domain/entities/request/forgot_password_request.dart';
import 'package:exams/features/auth/presentation/widget/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../../domain/entities/request/verify_reset_code_request.dart';
import '../cubit/verify_reset_code_cubit.dart';
import '../cubit/verify_reset_code_event.dart';
import '../cubit/verify_reset_code_state.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final VerifyResetCodeCubit cubit = getIt();
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = GoRouterState.of(context).extra as String;
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<VerifyResetCodeCubit, VerifyResetCodeState>(
        listener: (context, state) {
          switch (state.verifyResetCode.status) {
            case ResourceStatus.success:
              context.goNamed(RouteNames.resetPassword, extra: email);
              break;

            case ResourceStatus.error:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.verifyResetCode.message ?? "Something went wrong",
                  ),
                ),
              );
              break;

            default:
              break;
          }

          if (state.resendCode.status == ResourceStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Verification code sent again")),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Password', style: ThemeApp.text.medium20black),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                children: [
                  AuthHeader(
                    title: 'Email Verification',
                    description:
                        'Please enter your code that send to your\nemail address ',
                  ),
                  SizedBox(height: 32.h),
                  Pinput(
                    controller: codeController,
                    length: 4,
                    autofocus: true,
                    enabled:
                        state.verifyResetCode.status != ResourceStatus.loading,
                    onCompleted: (value) {
                      cubit.doIntent(
                        VerifyResetCodeCompleted(
                          VerifyResetCodeRequest(resetCode: value),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: ThemeApp.text.regular16black,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (state.resendCode.status ==
                              ResourceStatus.loading) {
                            return;
                          }
                          cubit.doIntent(
                            ResendCodePressed(
                              ForgotPasswordRequest(email: email),
                            ),
                          );
                        },
                        child: Text(
                          "Resend",
                          style: ThemeApp.text.medium16blue,
                        ),
                      ),
                    ],
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
