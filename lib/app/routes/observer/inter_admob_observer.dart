import 'package:flutter/material.dart';
import 'package:simple_clean_architure/app/app_configs.dart';

import '../../admob/Interstitial_ads.dart';
import '../application_route_name.dart';

InterAdsObserver interAdsObserver = InterAdsObserver();
class InterAdsObserver extends NavigatorObserver {
   int stepAds ;

   InterAdsObserver({this.stepAds = AppConfigs.defaultDisplayAds});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (route is DialogRoute) {
      return;
    }

    if (route.settings.name == ApplicationRouteName.home) {
      InterstitialAds().show();
      return;
    }

    if (route.settings.name == ApplicationRouteName.splash || route.settings.name == ApplicationRouteName.onBoarding) {
      InterstitialAds().load();
      return;
    }
    stepAds--;
    if (stepAds == 0) {
      InterstitialAds().show();
      stepAds = 3;
    }
    if (stepAds == 1) {
      InterstitialAds().load();
    }
  }
}
