import 'dart:convert';

import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  // Không được sửa dòng Order này nếu không hiểu!
  // ignore: invalid_annotation_target
  @Order(-4)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

// Make sure this is always registered before everything else
@LazySingleton(order: -3)
class AppPreferences {
  final SharedPreferences _preference;

  AppPreferences(this._preference);

  static const String keyAuthToken = 'KEY_AUTH_TOKEN';
  static const String keyRefreshToken = 'KEY_REFRESH_TOKEN';
  static const String keyDeviceToken = 'KEY_DEVICE_TOKEN';

  String? accessTokenAnonymous;

  String? get authToken {
    return isLoggedIn ? _preference.getString(keyAuthToken) : accessTokenAnonymous;
  }

  bool get isLoggedIn {
    return (_preference.getString(keyAuthToken)?.isNotEmpty ?? false);
  }

  Future<void> saveAuthToken(Auth? response) async {
    await _preference.setString(keyAuthToken, response?.accessToken ?? '');
    await _preference.setString(keyRefreshToken, response?.refreshToken ?? '');
  }

  Future<void> saveFirebase(String data) async {
    await _preference.setString('firebase', data);
  }

  void removeAuthToken() {
    _preference.remove(keyAuthToken);
  }

  Future<void> saveDeviceToken(String value) => _preference.setString(keyDeviceToken, value);

  String? getString(String key) {
    String? value = _preference.getString(key);
    if (value?.isEmpty == true) value = null;
    return value;
  }

  String get getDeviceToken {
    return (_preference.getString(keyDeviceToken) ?? '');
  }

  Future<void> logout() async {
    await _preference.remove(keyAuthToken);
    await _preference.remove(keyRefreshToken);
  }
}
