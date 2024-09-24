class UnitAdmob {
  final String appAdID;

  final String adsAdaptiveBannerID;

  final String adInterID;

  final String adNativeID;

  final String adRewardID;

  final String adOpenID;

  UnitAdmob({
    required this.appAdID,
    required this.adsAdaptiveBannerID,
    required this.adInterID,
    required this.adNativeID,
    required this.adRewardID,
    required this.adOpenID,
  });

  factory UnitAdmob.fromJson(Map<String, dynamic> json) {
    return UnitAdmob(
      appAdID: json['app_ad_id'] ??'',
      adsAdaptiveBannerID: json['banner_id'] ?? "",
      adInterID: json['interstitial'] ?? "",
      adNativeID: json['native'] ?? "",
      adRewardID: json['adRewardID'] ?? '',
      adOpenID: json['app_open'] ?? "",
    );
  }
}
