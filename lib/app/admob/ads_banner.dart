import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/app_configs.dart';
import '../models/admob_configs.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width;

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
  void didUpdateWidget(covariant AdsBanner oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    AdMobConfig configs = AppConfigs().admobConfig;
    if (!configs.isEnable) const SizedBox();
    if (_bannerAd == null) return const SizedBox();
    if (!_isLoaded) {
      return SizedBox(
        height: _bannerAd?.size.height.toDouble() ?? 0,
        width: _bannerAd?.size.width.toDouble() ?? 0,
      );
    }
    return SizedBox(
        height: _bannerAd?.size.height.toDouble(),
        width: _bannerAd?.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!));
  }

  void _loadAd() async {
    if (!context.mounted) {
      return;
    }
    AdMobConfig configs = AppConfigs().admobConfig;
    if (!configs.isEnable) return;
    await _bannerAd?.dispose();
    setState(() {
      _bannerAd = null;
      _isLoaded = false;
    });

    // Get an inline adaptive size for the current orientation.
    AdSize size = AdSize.getPortraitInlineAdaptiveBannerAdSize(_adWidth.truncate());
    _bannerAd = BannerAd(
      adUnitId: configs.unitAdmob.adsAdaptiveBannerID,
      size: AdSize.banner,
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          if (!context.mounted) {
            return;
          }
          print('Inline adaptive banner loaded: ${ad.responseInfo}');
          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }
          setState(() {
            _bannerAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _bannerAd!.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    super.dispose();
  }
}
