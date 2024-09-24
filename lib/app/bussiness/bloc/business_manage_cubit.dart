import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../tracking/tracking_key.dart';
import '../../tracking/tracking_service.dart';
import '../domain/repository/business_responsitory.dart';
import 'bussiness_state.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

//import for SkuDetailsWrapper
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

class BusinessManageCubit extends Cubit<BusinessManageState> {
  final BusinessRepository repository;

  BusinessManageCubit({required this.repository}) : super(BusinessManageInitial(productDetails: []));

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Future<void> getBusinessManage() async {
    try {
      emit(BusinessManageLoading(productDetails: []));
      final List<ProductDetails> productDetails = await repository.getPackage();
      print(state.licenseState);
      emit(BusinessManageLoaded(productDetails: productDetails, licenseState: state.licenseState));
    } catch (e, s) {
      emit(BusinessManageError(message: e.toString(), productDetails: state.productDetails));
    }
  }

  void initLicense() async {
    DateTime? expiredDate = await _getExpireDateFromBilling();

    if (expiredDate != null) {
      emit(BusinessManageLoaded(productDetails: state.productDetails, licenseState: HasLicense(expiredDate)));
    }
    else{
      await getBusinessManage();
    }

    _initListener();
  }

  void _initListener() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        // /_subscription.cancel();
        print('done');
      },
      onError: (Object error) {
        TrackingService.recordError(error, StackTrace.current);
        // handle error here.
      },
    );
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        TrackingService().trackFirebaseEvent(TrackingKey.purchasedPayment);
      }

      if (purchaseDetails.status == PurchaseStatus.pending) {
        emit(
          BusinessManageError(
            message: purchaseDetails.error?.message ?? '',
            productDetails: state.productDetails,
          ),
        );
      }

      if (purchaseDetails.status == PurchaseStatus.canceled) {
        TrackingService().trackFirebaseEvent(TrackingKey.cancelPayment);
      }

      if (purchaseDetails.status == PurchaseStatus.error) {
        emit(BusinessManageError(
          message: purchaseDetails.error?.message ?? '',
          productDetails: state.productDetails,
        ));
        TrackingService().trackFirebaseEvent(TrackingKey.errorPayment);
        // emit(PaymentError(purchaseDetails.error?.message ?? ''));
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
        emit(
          BusinessManageLoaded(
            productDetails: state.productDetails,
            licenseState: HasLicense(DateTime.now()),
            backToHome: true,
          ),
        );
      }
    }
  }

  void onLifePayment() {
    try {
      _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: state.productDetails[1]));
    } catch (e) {
      print(e);
      emit(BusinessManageError(message: e.toString(), productDetails: state.productDetails));
    }
  }

  void buySubWeekly(ProductDetails productDetails) async {
    try {
      _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
    } catch (e) {
      emit(BusinessManageError(message: e.toString(), productDetails: state.productDetails));
    }
  }

  void _purcharUpdate(PurchasesResultWrapper purchasesResult, BillingClient billingClientManager) async {
    emit(BusinessManageLoading(productDetails: state.productDetails));
    try {
      for (var purchase in purchasesResult.purchasesList) {
        if (purchase.purchaseState == PurchaseStateWrapper.purchased) {
          print(' PurchaseStateWrapper.purchased');
          emit(
            BusinessManageLoaded(
              productDetails: state.productDetails,
              licenseState: HasLicense(DateTime.now()),
              backToHome: true,
            ),
          );
        }
        if (purchase.purchaseState == PurchaseStateWrapper.pending) {
          emit(
            BusinessManageError(
              message: "Purchase pending",
              productDetails: state.productDetails,
            ),
          );
        }

        if (!purchase.isAcknowledged) {
          await billingClientManager.acknowledgePurchase(purchase.purchaseToken);
          print(' purchase.isAcknowledged');
          emit(
            BusinessManageLoaded(
              productDetails: state.productDetails,
              licenseState: HasLicense(DateTime.now()),
              backToHome: true,
            ),
          );
        }

      }
    } catch (e) {
      print('Init purchase error: $e');
    }
  }

  Duration getPeriodFromString(String periodString) {
    String first = periodString.substring(0, 1);
    String lastCharacter = periodString.substring(periodString.length - 1);
    String argument = periodString.substring(1, periodString.length - 1);
    int argumentInt = int.parse(argument);
    switch (lastCharacter) {
      case 'D':
        return Duration(days: argumentInt);
      case 'W':
        return Duration(days: argumentInt * 7);
      case 'M':
        return Duration(days: argumentInt * 30);
      case 'Y':
        return Duration(days: argumentInt * 365);
    }
    throw Exception('Invalid period string');
  }

  DateTime dateExpire({required int purchaseDateISO8601, required Duration period}) {
    var purchaseDate = DateTime.fromMillisecondsSinceEpoch(purchaseDateISO8601);
    var expireDate = purchaseDate.add(period);
    return expireDate;
  }

  bool isLicenseValid(DateTime expiredDate) {
    return expiredDate.difference(DateTime.now()) > Duration.zero;
  }

  late BillingClient billingClient;

  Future<DateTime?> _getExpireDateFromBilling() async {
    billingClient = BillingClient((purachaseResult) {
      _purcharUpdate(purachaseResult, billingClient);
    }, (value) {});

    var inApp = await billingClient.queryPurchases(ProductType.inapp);

    var listInApp = inApp.purchasesList;
    print('list in app  ${listInApp.length}');

    if (listInApp.isNotEmpty) {
      return DateTime.now().add(const Duration(days: 3650));
    }
    //
    // /// get subs history
    var purchaseSub = await billingClient.queryPurchases(ProductType.subs);
    var subList = purchaseSub.purchasesList;
    print('list sub  ${listInApp.length}');
    if (subList.isNotEmpty) {
      return DateTime.now().add(const Duration(days: 3650));
    }
    print('result null');
    return null;
  }

  GooglePlayProductDetails productByPurchase(GooglePlayPurchaseDetails purchaseDetails) {
    return state.productDetails.where((e) => e.id == purchaseDetails.productID).first as GooglePlayProductDetails;
  }
}
