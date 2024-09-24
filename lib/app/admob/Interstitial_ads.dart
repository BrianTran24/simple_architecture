
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/app_configs.dart';
import '../models/admob_configs.dart';

const int maxFailedLoadAttempts = 3;

class  InterstitialAds {

  static InterstitialAds? _instance = InterstitialAds._();
  InterstitialAds._();

  factory InterstitialAds() => _instance ??= InterstitialAds._();

  int _numInterstitialLoadAttempts = 0;

  InterstitialAd? _interstitialAd;

  static DateTime loadedTime = DateTime.now();

  void load() async {
    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return;
    if (_interstitialAd != null) {
      return;
    }
    loadedTime = DateTime.now();
    await InterstitialAd.load(
      adUnitId: configs.unitAdmob.adInterID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            load();
          }
        },
      ),
    );
    print(DateTime.now());
  }

  void show({VoidCallback? onClose}) async{
    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return;
    await Future.delayed(const Duration(milliseconds: 500));
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdWillDismissFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdWillDismissFullScreenContent.');
        ad.dispose();
        load();
        onClose?.call();
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        load();
        onClose?.call();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        load();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
