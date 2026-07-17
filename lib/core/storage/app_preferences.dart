abstract class AppPreferences {
  Future<void> setRememberMe(bool value);

  Future<bool> getRememberMe();
}
