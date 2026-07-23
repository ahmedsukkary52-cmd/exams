import 'dart:async';

import 'package:exams/features/auth/domain/entities/response/reset_password_response.dart';
import 'package:exams/features/auth/presentation/reset_password/cubit/reset_password_event.dart';
import 'package:exams/features/auth/presentation/reset_password/cubit/reset_password_state.dart';
import 'package:exams/features/auth/presentation/reset_password/cubit/reset_password_ui_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/reset_password_use_case.dart';

@lazySingleton
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordUseCase)
    : super(ResetPasswordState(resetPassword: Resource.initial()));
  final ResetPasswordUseCase resetPasswordUseCase;
  final _uiEvents = StreamController<ResetPasswordUiEvent>.broadcast();

  Stream<ResetPasswordUiEvent> get uiEvents => _uiEvents.stream;

  Future<void> doIntent(ResetPasswordEvent event) async {
    switch (event) {
      case ResetPasswordPressed():
        _resetPassword(event);
      case ResetPasswordFormChanged():
        emit(state.copyWith(isFormValid: event.isValid));
    }
  }

  Future<void> _resetPassword(ResetPasswordPressed event) async {
    emit(state.copyWith(resetPassword: Resource.loading()));
    final result = await resetPasswordUseCase(event.request);
    switch (result) {
      case Success():
        emit(state.copyWith(resetPassword: Resource.success(result.data)));
        _uiEvents.add(NavigateToLogin());

      case Failure<ResetPasswordResponse>():
        emit(
          state.copyWith(
            resetPassword: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
        _uiEvents.add(
          ShowError(result.error.message ?? 'Something went wrong'),
        );
    }
  }

  @override
  Future<void> close() async {
    await _uiEvents.close();
    return super.close();
  }
}
