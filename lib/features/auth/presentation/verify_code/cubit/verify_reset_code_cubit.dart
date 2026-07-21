import 'package:exams/core/base/resources.dart';
import 'package:exams/features/auth/presentation/verify_code/cubit/verify_reset_code_event.dart';
import 'package:exams/features/auth/presentation/verify_code/cubit/verify_reset_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/forgot_password_use_case.dart';
import '../../../domain/usecases/verify_reset_code_use_case.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  VerifyResetCodeCubit({
    required this.verifyResetCodeUseCase,
    required this.forgotPasswordUseCase,
  }) : super(
         VerifyResetCodeState(
           verifyResetCode: Resource.initial(),
           resendCode: Resource.initial(),
         ),
       );

  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  Future<void> doIntent(VerifyResetCodeEvent event) async {
    switch (event) {
      case VerifyResetCodeCompleted():
        _verifyResetCode(event);
      case ResendCodePressed():
        _resendCode(event);
    }
  }

  Future<void> _verifyResetCode(VerifyResetCodeCompleted event) async {
    emit(state.copyWith(verifyResetCode: Resource.loading()));
    final result = await verifyResetCodeUseCase(event.request);
    switch (result) {
      case Success():
        emit(state.copyWith(verifyResetCode: Resource.success(result.data)));
      case Failure():
        emit(
          state.copyWith(
            verifyResetCode: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
    }
  }

  Future<void> _resendCode(ResendCodePressed event) async {
    emit(state.copyWith(resendCode: Resource.loading()));
    final result = await forgotPasswordUseCase(event.request);
    switch (result) {
      case Success():
        emit(state.copyWith(resendCode: Resource.success(result.data)));
      case Failure():
        emit(
          state.copyWith(
            resendCode: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
    }
  }
}
