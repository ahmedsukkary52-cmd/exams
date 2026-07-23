sealed class ResetPasswordUiEvent {}

class NavigateToLogin extends ResetPasswordUiEvent {}

class ShowError extends ResetPasswordUiEvent {
  final String message;

  ShowError(this.message);
}
