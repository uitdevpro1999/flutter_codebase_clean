import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_codebase_clean/core/common/bases/enum/app_date_format.dart';
import 'package:flutter_codebase_clean/core/local_storage/share_preferences.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
class GoogleAnalyticsManager {
  GoogleAnalyticsManager();
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  static const String eventOpen = 'open_app';
  static const String eventClose = 'close_app';
  static const String eventLogin = 'login';
  static const String eventPageView = 'page_view';
  static const String eventClick = 'button_click';

  static Future<String?> _getId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  Future<void> track(String eventName, {Map<String, String>? value}) async {
    final deviceId = await _getId();
    final userId = '$deviceId';
    await _firebaseAnalytics.setUserId(id: userId);
    final time = DateFormat(AppDateFormat.dayMonthYearHourMinute.formatString)
        .format(DateTime.now());
    final Map<String, String> map = {
      'userId': userId,
      'time': time,
    };
    if (value != null) map.addAll(value);
    await Future.forEach(map.entries, (MapEntry<dynamic, dynamic> entry) async {
      await _firebaseAnalytics.setUserProperty(
          name: entry.key, value: entry.value);
    });
    await _firebaseAnalytics.logEvent(name: eventName, parameters: map);
  }

  void trackLogin() {
    track(eventLogin);
  }

  void trackScreen(String screenName, String type) {
    track(eventPageView, value: {'type': type, 'screenName': screenName});
  }

  void trackOpenApp() {
    track(eventOpen);
  }

  void trackCloseApp() {
    track(eventClose);
  }

  Future<void> trackClick(String buttonName) async {
    await _firebaseAnalytics.setUserProperty(
        name: 'buttonName', value: buttonName);
    await track(eventClick, value: {'buttonName': buttonName});
  }
}
