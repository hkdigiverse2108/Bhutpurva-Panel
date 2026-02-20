import 'package:get_storage/get_storage.dart';

class StorageService {
  final storage = GetStorage();

  // Define keys
  static const String tokenKey = 'token';
  static const String userKey = 'user';
  static const String themeKey = 'theme';
  static const String roleKey = 'role';

  // static const String roleKey = 'role';

  // Token
  String? get token => storage.read(tokenKey);

  set token(String? value) =>
      value == null ? storage.remove(tokenKey) : storage.write(tokenKey, value);

  // User
  Map<String, dynamic>? get user => storage.read(userKey);

  set user(Map<String, dynamic>? value) =>
      value == null ? storage.remove(userKey) : storage.write(userKey, value);

  // Role
  String? get role => storage.read(roleKey);

  set role(String? value) =>
      value == null ? storage.remove(roleKey) : storage.write(roleKey, value);

  // login
  bool get isLoggedIn => token != null;

  // Theme
  String? get theme => storage.read(themeKey);

  set theme(String? value) => storage.write(themeKey, value);

  // Generic read/write methods for future extensibility
  dynamic read(String key) => storage.read(key);

  void write(String key, dynamic value) => storage.write(key, value);

  void remove(String key) => storage.remove(key);

  void clearAll() => storage.erase();
}
