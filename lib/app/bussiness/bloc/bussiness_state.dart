
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class LicenseState {
  const LicenseState();
}

class NoLicense extends LicenseState {
  const NoLicense();
}

class HasLicense extends LicenseState {
  final DateTime expirationDate;

  HasLicense(this.expirationDate);
}

abstract class BusinessManageState {
  final List<ProductDetails> productDetails;

  final LicenseState? licenseState;

  BusinessManageState({required this.productDetails, this.licenseState = const NoLicense()});
}

class BusinessManageInitial extends BusinessManageState {
  BusinessManageInitial({required super.productDetails});
}

class BusinessManageLoading extends BusinessManageState {
  BusinessManageLoading({required super.productDetails});
}

class BusinessManageLoaded extends BusinessManageState {
  final bool backToHome;
  BusinessManageLoaded( {required super.productDetails, required super.licenseState, this.backToHome =false,});
}

class BusinessManageError extends BusinessManageState {
  final String message;

  BusinessManageError({required this.message, required super.productDetails});
}
