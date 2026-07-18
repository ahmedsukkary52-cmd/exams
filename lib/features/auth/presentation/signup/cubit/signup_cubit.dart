import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/resources.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/storage/token_storage.dart';
import '../../../domain/usecases/signup_use_case.dart';
import 'signup_events.dart';
import 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;
  final TokenStorage tokenStorage;

  SignupCubit(this.signupUseCase, this.tokenStorage)
    : super(SignupState(Resource.initial()));

  Future<void> doIntent(SignupEvents event) async {
    switch (event) {
      case SignupPressed():
        _signup(event);

      case SignupFormChanged():
        emit(state.copyWith(isFormValid: event.isValid));
    }
  }

  Future<void> _signup(SignupPressed event) async {
    emit(state.copyWith(signup: Resource.loading()));

    final result = await signupUseCase(event.request);

    switch (result) {
      case Success():
        await tokenStorage.saveAccessToken(result.data.token!);
        emit(state.copyWith(signup: Resource.success(result.data)));

      case Failure():
        emit(
          state.copyWith(
            signup: Resource.error(
              message: result.error.message,
              exception: result.error.exception,
            ),
          ),
        );
    }
  }
}
