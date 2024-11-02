import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codebase_clean/core/extensions/string_ext.dart';
import 'package:flutter_codebase_clean/core/local_storage/share_preferences.dart';
import 'package:flutter_codebase_clean/core/logger/logger.dart';
import 'package:flutter_codebase_clean/injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NotificationsManager {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _prefs = getIt<AppPreferences>();

  Future<void> initial() async {
    await generateDeviceToken();
  }

  Future<String?> generateDeviceToken() async {
    final deviceToken = await _firebaseMessaging.getToken();
    if (deviceToken?.isNotNullOrEmpty ?? false) {
      await _prefs.saveDeviceToken(deviceToken!);
    }
    return deviceToken;
  }

  Future<void> handleReceivePushNotification(
      {required ValueChanged<RemoteMessage> onTerminal,
      required ValueChanged<RemoteMessage> onForeground,
      required ValueChanged<RemoteMessage> onBackground}) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    //check permission for ios
    await firebaseMessaging.requestPermission().then((value) =>
        logger.d('User granted permission: ${value.authorizationStatus}'));
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      await FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        logger.d('on terminal $message');
        if (message != null) {
          onTerminal.call(message);
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        logger.d('on message: $message');
        final json = jsonEncode(message.toMap());
        await GetIt.instance.get<AppPreferences>().saveFirebase(json);
        onForeground.call(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        logger.d('on background: message');
        onBackground.call(message);
      });
    } catch (e) {
      logger.e(e);
    }
  }
}
