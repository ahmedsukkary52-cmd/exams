import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/forgot_password_use_case.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.forgotPasswordUseCase)
    : super(ForgotPasswordState(forgotPassword: Resource.initial()));
  final ForgotPasswordUseCase forgotPasswordUseCase;

  Future<void> doIntent(ForgotPasswordEvent event) async {
    switch (event) {
      case ForgotPasswordPressed():
        _forgotPassword(event);

      case ForgotPasswordFormChanged():
        emit(state.copyWith(isFormValid: event.isValid));
    }
  }

  Future<void> _forgotPassword(ForgotPasswordPressed event) async {
    emit(state.copyWith(forgotPassword: Resource.loading()));
    final result = await forgotPasswordUseCase(event.request);
    switch (result) {
      case Success():
        emit(state.copyWith(forgotPassword: Resource.success(result.data)));

      case Failure():
        emit(
          state.copyWith(
            forgotPassword: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
    }
  }
}
