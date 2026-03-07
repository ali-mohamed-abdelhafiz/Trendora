class AddProductModel {
  final String message;
  final String id;
  final String productId;
  final int quantity;

  AddProductModel(
      {required this.message,
      required this.id,
      required this.productId,
      required this.quantity});

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return AddProductModel(
        message: json['message'] ?? '',
        id: json['id'] ?? '',
        productId: json['productId'] ?? '',
        quantity: json['quantity'] ?? '');
  }
}
