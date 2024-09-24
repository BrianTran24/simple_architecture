import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class TrackingService {
  static final TrackingService shared = TrackingService._internal();

  factory TrackingService() => shared;

  TrackingService._internal();

  final _analytics = FirebaseAnalytics.instance;

  void setUserId(String uid) {
    _analytics.setUserId(id: uid);
  }

  void logout() {
    _analytics.setUserId(id: null);
  }

  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    return _analytics.setUserProperty(name: name, value: value);
  }

  void trackEvent(String eventName, [Map<String, dynamic>? params]) {
    _analytics.logEvent(name: eventName, parameters: {'data': params.toString()});
  }

  void trackFirebaseEvent(String eventName, [Map<String, Object>? params]) {
    _analytics.logEvent(name: eventName, parameters: params);
  }

  void trackScreen(String screenName) {
    _analytics.logScreenView(screenClass: screenName, screenName: screenName);
  }

  static Future<void> recordError(dynamic error, StackTrace? stack, {String? reason}) async {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, reason: reason);
    }
  }
}
