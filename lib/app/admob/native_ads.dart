import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/app_configs.dart';
import '../models/admob_configs.dart';

class NativeAds extends StatefulWidget {
  const NativeAds({super.key,  this.boxConstraints = const BoxConstraints(
    minWidth: 300,
    minHeight: 350,
    maxHeight: 400,
    maxWidth: 450,
  )});

  final BoxConstraints boxConstraints;

  @override
  NativeAdsState createState() => NativeAdsState();
}

class NativeAdsState extends State<NativeAds> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  Widget build(BuildContext context) {
    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return const SizedBox();
    if (_nativeAd != null && _nativeAdIsLoaded) {
      return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: widget.boxConstraints,
            child: AdWidget(ad: _nativeAd!),
          )
      );
    }
    return const SizedBox.shrink();
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return;
    _nativeAd = NativeAd(
      adUnitId: configs.unitAdmob.adNativeID,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }
}
