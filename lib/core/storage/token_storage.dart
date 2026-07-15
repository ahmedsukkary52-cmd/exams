abstract class TokenStorage {
  Future<String?> getAccessToken();

  Future<void> saveAccessToken(String token);

  Future<void> deleteAccessToken();

  Future<void> clear();
}
