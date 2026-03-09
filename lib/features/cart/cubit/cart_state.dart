part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartSuccess extends CartState {
  final List<CartData> carts;
  final double subTotal;
  final double vat;
  final double shippingFees;
  final double total;

  CartSuccess(
    this.carts, {
    required this.subTotal,
    required this.vat,
    required this.shippingFees,
    required this.total,
  });
}

class DeleteCartError extends CartState {
  final String message;
  DeleteCartError(this.message);
}

class DeleteCartSuccess extends CartState {}

class UpdateCartLoading extends CartState {}

class UpdateCartError extends CartState {
  final String message;
  UpdateCartError(this.message);
}

class UpdateCartSuccess extends CartState {}
