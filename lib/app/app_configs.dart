import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'models/admob_configs.dart';
import 'models/payment_model.dart';

class AppConfigs {
  static final AppConfigs _instance = AppConfigs._();

  factory AppConfigs() => _instance;

  AppConfigs._();

  static const String androidID = 'com.iptv.smartplayer.tvmate.tvpro';

  static const String iosID = 'com.iptv.smartplayer.tvmate.tvpro';

  static String appID() => Platform.isAndroid ? androidID : iosID;

  static String  get androidStoreUrl => 'https://play.google.com/store/apps/details?id=$androidID';

  static String  get iosStoreUrl => 'https://apps.apple.com/us/app/company/id$iosID';

  static String storeUrl() => Platform.isAndroid ? androidStoreUrl : iosStoreUrl;

  static const String searchPopularChannel = 'https://www.google.com/search?q=Free+Popular+IPTV+Playlist';

  static const String privacyPolicy = 'https://kamvie-team.web.app/privacy.html';

  static const String termOfService = 'https://kamvie-team.web.app/terms.html';

  static const String webSite = 'https://hmlstudio.net/';

  static const String mailTo = 'kamvieteam@gmail.com';


  /// default 15 minutes
  static const int defaultTimeShowInterAdInVideo = 15;

  static const int defaultDisplayAds = 3;

  AdMobConfig get admobConfig => _admobConfig;
  late AdMobConfig _admobConfig;

  Payments get payments => _getPayment;
  late Payments _getPayment;

  Future<void> setup() async {
    await _setupRemoteConfig();
    await _setupRepository();
    // await AppSharePreference.init();
    // await LocalDatabase().init();
  }

  Future<void> _setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    RemoteConfigSettings remoteConfigSettings = RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    );

    await remoteConfig.setConfigSettings(remoteConfigSettings);
    _admobConfig = await _getAdMobConfig(remoteConfig);
    _getPayment = await _getPaymentConfig(remoteConfig);
  }

  Future<void> _setupRepository() async {}

  Future<AdMobConfig> _getAdMobConfig(FirebaseRemoteConfig remoteConfig) async {
    if (kDebugMode) {
      return debugAdMobConfig;
    }

    bool isActive = await remoteConfig.fetchAndActivate();
    debugPrint('isActive: $isActive');
    String value = remoteConfig.getString('admob_configs');
    dynamic object = jsonDecode(value);

    if (Platform.isIOS) {
      return AdMobConfig.fromJson(object['ios']);
    }
    return AdMobConfig.fromJson(object['android']);
  }

  Future<Payments> _getPaymentConfig(FirebaseRemoteConfig remoteConfig) async {
    bool isActive = await remoteConfig.fetchAndActivate();
    String value = remoteConfig.getString('in_app_purchase');
    dynamic object = jsonDecode(value);
    return Payments.fromJson(object);
  }
}




