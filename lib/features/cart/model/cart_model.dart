class CartModel {
  final String cartId;
  final List<CartData> cartItems;

  CartModel({required this.cartId, required this.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        cartId: json['cartId'],
        cartItems: (json['cartItems'] as List<dynamic>?)
                ?.map((e) => CartData.fromJson(e))
                .toList() ??
            []);
  }
}

class CartData {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final num weightInGrams;
  final int quantity;
  final num discountPercentage;
  final num basePricePerUnit;
  final num finalPricePerUnit;
  final num totalPrice;

  CartData(
      {required this.itemId,
      required this.productId,
      required this.productName,
      required this.productCoverUrl,
      required this.productStock,
      required this.weightInGrams,
      required this.quantity,
      required this.discountPercentage,
      required this.basePricePerUnit,
      required this.finalPricePerUnit,
      required this.totalPrice});

  CartData copyWith({
    String? itemId,
    String? productId,
    String? productName,
    String? productCoverUrl,
    int? productStock,
    num? weightInGrams,
    int? quantity,
    num? discountPercentage,
    num? basePricePerUnit,
    num? finalPricePerUnit,
    num? totalPrice,
  }) {
    return CartData(
      itemId: itemId ?? this.itemId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCoverUrl: productCoverUrl ?? this.productCoverUrl,
      productStock: productStock ?? this.productStock,
      weightInGrams: weightInGrams ?? this.weightInGrams,
      quantity: quantity ?? this.quantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      basePricePerUnit: basePricePerUnit ?? this.basePricePerUnit,
      finalPricePerUnit: finalPricePerUnit ?? this.finalPricePerUnit,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
        itemId: json['itemId'] ?? '',
        productId: json['productId'] ?? '',
        productName: json['productName'] ?? '',
        productCoverUrl: json['productCoverUrl'] ?? '',
        productStock: json['productStock'] ?? '',
        weightInGrams: json['weightInGrams'] ?? '',
        quantity: json['quantity'] ?? '',
        discountPercentage: json['discountPercentage'] ?? '',
        basePricePerUnit: json['basePricePerUnit'] ?? '',
        finalPricePerUnit: json['finalPricePerUnit'] ?? '',
        totalPrice: json['totalPrice'] ?? '');
  }
}
