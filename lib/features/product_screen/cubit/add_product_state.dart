part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final AddProductModel model;

  AddProductSuccess(this.model);
}

final class AddProductError extends AddProductState {
  final ErrorModel error;

  AddProductError(this.error);
}
