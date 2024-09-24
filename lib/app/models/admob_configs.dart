import 'admob_unit.dart';

class AdMobConfig {
  final UnitAdmob unitAdmob;
  bool _isEnable;

  AdMobConfig({required this.unitAdmob, required bool isEnable}) : _isEnable = isEnable;

  factory AdMobConfig.fromJson(Map<String, dynamic> json) {
    return AdMobConfig(
      unitAdmob: UnitAdmob.fromJson(json['unit_id']),
      isEnable: json['is_enable'] ?? false,
    );
  }

  bool get isEnable => _isEnable;

  void setEnable(bool enable) {
    _isEnable = enable;
  }
}

AdMobConfig debugAdMobConfig = AdMobConfig(
  unitAdmob: UnitAdmob(
    appAdID: 'ca-app-pub-3940256099942544~3347511713',
    adsAdaptiveBannerID: 'ca-app-pub-3940256099942544/9214589741',
    adInterID: 'ca-app-pub-3940256099942544/1033173712',
    adNativeID: 'ca-app-pub-3940256099942544/2247696110',
    adRewardID: 'ca-app-pub-3940256099942544/5224354917',
    adOpenID: 'ca-app-pub-3940256099942544/9257395921',
  ),
  isEnable: true,
);
