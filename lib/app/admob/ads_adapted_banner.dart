
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../app_configs.dart';
import '../models/admob_configs.dart';


class AdmobAdaptedBanner extends StatefulWidget {
  const AdmobAdaptedBanner({super.key});

  @override
  State<AdmobAdaptedBanner> createState() => _AdmobAdaptedBannerState();
}

class _AdmobAdaptedBannerState extends State<AdmobAdaptedBanner> {
  static const _insets = 16.0;
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);



  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return const SizedBox();

    if (_inlineAdaptiveAd == null) return const SizedBox();
    if(!_isLoaded) return const SizedBox();
    return AdWidget(ad: _inlineAdaptiveAd!);
  }

  void _loadAd() async {
    if(!context.mounted){
      return;
    }

    AdMobConfig  configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return;

    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    // Get an inline adaptive size for the current orientation.
    AdSize size = AdSize.getPortraitInlineAdaptiveBannerAdSize(_adWidth.truncate());


    _inlineAdaptiveAd = AdManagerBannerAd(
      adUnitId: configs.unitAdmob.adsAdaptiveBannerID,
      sizes: [size],
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          debugPrint('Inline adaptive banner loaded: ${ad.responseInfo}');
          // After the ad is loaded, get the platform ad size and use it to
          // update the height of the container. This is necessary because the
          // height can change after the ad is loaded.
          AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            debugPrint('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }
}
