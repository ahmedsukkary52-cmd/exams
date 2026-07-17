import 'package:exams/core/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';

@LazySingleton(as: AppPreferences)
class AppPreferencesImpl implements AppPreferences {
  final SharedPreferences prefs;

  AppPreferencesImpl(this.prefs);

  @override
  Future<void> setRememberMe(bool value) async {
    await prefs.setBool(StorageKeys.rememberMe, value);
  }

  @override
  Future<bool> getRememberMe() async {
    return prefs.getBool(StorageKeys.rememberMe) ?? false;
  }
}
