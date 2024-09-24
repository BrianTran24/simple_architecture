
class Payments {
  final List<PurchaseItem> inAppPurchase;
  final List<PurchaseItem> subscriptions;


  Payments({
    required this.inAppPurchase,
    required this.subscriptions,
  });

  Payments copyWith({
    List<PurchaseItem>? inAppPurchase,
    List<PurchaseItem>? subscriptions,
  }) =>
      Payments(
        inAppPurchase: inAppPurchase ?? this.inAppPurchase,
        subscriptions: subscriptions ?? this.subscriptions,
      );

  factory Payments.fromJson(Map<String, dynamic> json) {
    var data = json["payments"];
    return Payments(
      inAppPurchase: List<PurchaseItem>.from(data["in_app_purchase"].map((x) => PurchaseItem.fromJson(x))),
      subscriptions: List<PurchaseItem>.from(data["subscriptions"].map((x) => PurchaseItem.fromJson(x))),
    );
  }
}

class PurchaseItem {
  final String id;
  final String originalPrice;
  final String discountPercent;
  final String price;

  PurchaseItem({
    required this.id,
    required this.originalPrice,
    required this.discountPercent,
    required this.price,
  });

  PurchaseItem copyWith({
    String? id,
    String? originalPrice,
    String? discountPercent,
    String? price,
  }) =>
      PurchaseItem(
        id: id ?? this.id,
        originalPrice: originalPrice ?? this.originalPrice,
        discountPercent: discountPercent ?? this.discountPercent,
        price: price ?? this.price,
      );

  factory PurchaseItem.fromJson(Map<String, dynamic> json) => PurchaseItem(
        id: json["id"]??'',
        originalPrice: json["original_price"]??'',
        discountPercent: json["discount_percent"]??'',
        price: json["price"]??"",
      );
}
