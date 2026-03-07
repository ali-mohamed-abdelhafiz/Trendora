import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/model/cart_model.dart';
import 'package:ecommerce_app/features/cart/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepo) : super(CartInitial());
  final CartRepo _cartRepo;

  // احتفظ بالـ list الحالية هنا
  List<CartData> _currentCarts = [];

  void fetchCarts() async {
    emit(CartLoading());
    final response = await _cartRepo.getCart();
    response.fold(
      (ifLeft) => emit(CartError(ifLeft)),
      (ifRight) {
        _currentCarts = ifRight; // احفظ الـ list
        emit(CartSuccess(ifRight));
      },
    );
  }

  Future<void> deleteCartItem(String id) async {
    final oldCarts = _currentCarts;

    final updatedCarts =
        _currentCarts.where((item) => item.itemId != id).toList();

    _currentCarts = updatedCarts;

    emit(CartSuccess(updatedCarts));

    final result = await _cartRepo.deleteCart(id: id);

    result.fold(
      (error) {
        _currentCarts = oldCarts;
        emit(CartSuccess(oldCarts));
        emit(DeleteCartError(error));
      },
      (success) {
        emit(DeleteCartSuccess());
      },
    );
  }
}
  
  // Future updateCartQuantity(String id, int quantity) async {
    //   emit(UpdateCartLoading());

    //   final result =
    //       await _cartRepo.updateCartQuantity(id: id, quantity: quantity);

    //   result.fold(
    //     (error) {
    //       emit(UpdateCartError(error));
    //     },
    //     (data) {
    //       emit(UpdateCartSuccess());
    //     },
    //   );
    // }
