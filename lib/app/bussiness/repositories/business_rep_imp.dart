import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import '../../app_configs.dart';
import '../domain/repository/business_responsitory.dart';

const Set<String> _kIOSIds = <String>{'subs_weeklytrial', 'iptv_lifetime'};
const Set<String> _kAndroids = <String>{'iptv_weekly', 'iptv_lifetime'};

class BusinessRepositoryImp implements BusinessRepository {
  BusinessRepositoryImp();

  @override
  Future<List<ProductDetails>> getPackage() async {
    Set<String> _kIds = {
      ...AppConfigs().payments.subscriptions.map((e) => e.id),
      ...AppConfigs().payments.inAppPurchase.map((e) => e.id),
    };

    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
    var result = response.productDetails.reversed.toList().where((element) => element.rawPrice!=0).toList();
    return result;
  }

  Set<String> _getIds() {
    /// Add flavor here
    if (Platform.isIOS) {
      return _kIOSIds;
    } else {
      return _kAndroids;
    }
  }
}
