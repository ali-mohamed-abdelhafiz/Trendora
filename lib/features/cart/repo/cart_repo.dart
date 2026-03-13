import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/api_error_handler.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/cart/model/cart_model.dart';

class CartRepo {
  final DioHelper _dioHelper;

  CartRepo(this._dioHelper);

  Future<Either<String, List<CartData>>> getCart() async {
    try {
      Response response =
          await _dioHelper.getRequest(endPoint: ApiEndpoints.getCartEndpoint);
      if (response.statusCode == 200) {
        final data = CartModel.fromJson(response.data);
        return Right(data.cartItems);
      } else {
        return const Left('Something Went Wrong');
      }
    } catch (e) {
      return Left(ApiErrorHandler2.handle(e));
    }
  }

  Future<Either<String, bool>> deleteCart({
    required String id,
  }) async {
    try {
      Response response = await _dioHelper.deleteRequest(
        endPoint: "${ApiEndpoints.cartEndpoint}/$id",
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      } else {
        return const Left("Something Went Wrong");
      }
    } catch (e) {
      return Left(ApiErrorHandler2.handle(e));
    }
  }

  Future<Either<String, List<CartData>>> updateCartQuantity({
    required String id,
    required int quantity,
  }) async {
    try {
      Response response = await _dioHelper.putRequest(
        endPoint: "${ApiEndpoints.cartEndpoint}/$id",
        data: {'id': id, 'quantity': quantity},
      );

      if (response.statusCode == 200) {
        final data = CartModel.fromJson(response.data);
        return Right(data.cartItems);
      } else {
        return const Left("Something Went Wrong");
      }
    } catch (e) {
      return Left(ApiErrorHandler2.handle(e));
    }
  }
}
