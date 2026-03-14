import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tendora/features/auth/model/error_model.dart';
import 'package:tendora/features/product_screen/model/add_product_model.dart';
import 'package:tendora/features/product_screen/repo/add_product_repo.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._addProductRepo) : super(AddProductInitial());
  final AddProductRepo _addProductRepo;

  void addProduct({required String productId, required int quantity}) async {
    emit(AddProductLoading());

    final Either<ErrorModel, AddProductModel> response = await _addProductRepo
        .addToCart(productId: productId, quantity: quantity);

    response.fold((error) => emit(AddProductError(error)),
        (right) => emit(AddProductSuccess(right)));
  }
}
