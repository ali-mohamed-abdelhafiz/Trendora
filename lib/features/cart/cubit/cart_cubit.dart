import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/model/cart_model.dart';
import 'package:ecommerce_app/features/cart/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepo) : super(CartInitial());
  final CartRepo _cartRepo;

  List<CartData> _currentCarts = [];

  void fetchCarts() async {
    emit(CartLoading());
    final response = await _cartRepo.getCart();
    response.fold(
      (ifLeft) => emit(CartError(ifLeft)),
      (ifRight) {
        _currentCarts = ifRight;
        emit(_buildCartSuccess(ifRight));
      },
    );
  }

  Future<void> deleteCartItem(String id) async {
    final oldCarts = _currentCarts;

    final updatedCarts =
        _currentCarts.where((item) => item.itemId != id).toList();

    _currentCarts = updatedCarts;

    emit(_buildCartSuccess(updatedCarts));

    final result = await _cartRepo.deleteCart(id: id);

    result.fold(
      (error) {
        _currentCarts = oldCarts;
        emit(_buildCartSuccess(oldCarts));
        emit(DeleteCartError(error));
      },
      (success) {
        emit(DeleteCartSuccess());
      },
    );
  }

  CartSuccess _buildCartSuccess(List<CartData> carts) {
    double subTotal =
        carts.fold(0, (sum, item) => sum + item.totalPrice * item.quantity);
    double vat = subTotal * 0.16;
    double shipping = subTotal > 1000 ? 0 : 50;
    double total = subTotal + vat + shipping;

    return CartSuccess(
      carts,
      subTotal: subTotal,
      vat: vat,
      shippingFees: shipping,
      total: total,
    );
  }

  Future<void> incrementCartItem(String id) async {
    final oldCarts = List<CartData>.from(_currentCarts);
    final index = _currentCarts.indexWhere((item) => item.itemId == id);
    if (index == -1) return;

    // تحديث محلي سريع للـ UI (Optimistic Update)
    _currentCarts[index] = _currentCarts[index]
        .copyWith(quantity: _currentCarts[index].quantity + 1);
    emit(_buildCartSuccess(List<CartData>.from(_currentCarts)));

    // إرسال التحديث للسيرفر
    final result = await _cartRepo.updateCartQuantity(
      id: id,
      quantity: _currentCarts[index].quantity,
    );

    result.fold(
      (error) {
        // لو فيه خطأ ارجع النسخة القديمة
        _currentCarts = oldCarts;
        emit(_buildCartSuccess(List<CartData>.from(oldCarts)));
        emit(UpdateCartError(error));
      },
      (data) {
        // بدل محاولة تعيين data كامل، خليك على النسخة المحلية
        emit(_buildCartSuccess(List<CartData>.from(_currentCarts)));
        emit(UpdateCartSuccess());
      },
    );
  }
}
