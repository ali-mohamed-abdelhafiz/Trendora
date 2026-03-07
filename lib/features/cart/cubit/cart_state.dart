part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<CartData> carts;

  CartSuccess(this.carts);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}

class DeleteCartLoading extends CartState {}

class DeleteCartSuccess extends CartState {}

class DeleteCartError extends CartState {
  final String message;

  DeleteCartError(this.message);
}

// class UpdateCartLoading extends CartState {}

// class UpdateCartSuccess extends CartState {}

// class UpdateCartError extends CartState {
//   final String message;

//   UpdateCartError(this.message);
// }
