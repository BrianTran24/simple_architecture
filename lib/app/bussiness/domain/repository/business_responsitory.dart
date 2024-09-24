import 'package:in_app_purchase/in_app_purchase.dart';

abstract class BusinessRepository {
  Future<List<ProductDetails>> getPackage();
}