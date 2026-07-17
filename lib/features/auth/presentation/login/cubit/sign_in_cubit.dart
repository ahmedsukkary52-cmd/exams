import 'package:exams/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:exams/features/auth/presentation/login/cubit/sign_in_event.dart';
import 'package:exams/features/auth/presentation/login/cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/storage/app_preferences.dart';
import '../../../../../core/storage/token_storage.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final TokenStorage tokenStorage;
  final AppPreferences appPreferences;

  SignInCubit(this.signInUseCase, this.tokenStorage, this.appPreferences)
    : super(SignInState(auth: Resource.initial()));

  Future<void> doIntent(SignInEvents event) async {
    switch (event) {
      case SignInPressed():
        _signIn(event);

      case SignInFormChanged():
        emit(state.copyWith(isFormValid: event.isValid));

      case RememberMeChanged():
        await appPreferences.setRememberMe(event.value);
        emit(state.copyWith(rememberMe: event.value));
    }
  }

  Future<void> _signIn(SignInPressed event) async {
    emit(state.copyWith(auth: Resource.loading()));

    final result = await signInUseCase(event.request);

    switch (result) {
      case Success():
        if (state.rememberMe) {
          await tokenStorage.saveAccessToken(result.data.token!);
        }
        emit(state.copyWith(auth: Resource.success(result.data)));

      case Failure():
        emit(
          state.copyWith(
            auth: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
    }
  }
}
