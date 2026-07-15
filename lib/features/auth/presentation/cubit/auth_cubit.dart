import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/resources.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/signup_use_case.dart';
import 'auth_events.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignupUseCase signupUseCase;

  AuthCubit(this.signupUseCase) : super(AuthState(Resource.initial()));

  Future<void> doIntent(AuthEvents event) async {
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
