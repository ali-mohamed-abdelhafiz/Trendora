import 'dart:developer';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/api_error_handler.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/auth/model/error_model.dart';
import 'package:ecommerce_app/features/product_screen/model/add_product_model.dart';

class AddProductRepo {
  final DioHelper _dioHelper;
  AddProductRepo(this._dioHelper);

  Future<Either<ErrorModel, AddProductModel>> addToCart(
      {required String productId, required int quantity}) async {
    try {
      Response response = await _dioHelper
          .postRequest(endPoint: ApiEndpoints.cartEndpoint, data: {
        'productId': productId,
        'quantity': quantity,
      });
      log(productId.toString());
      if (response.statusCode == 200) {
        return Right(AddProductModel.fromJson(response.data));
      } else {
        log('Ali22: ${response.statusMessage}');
        return Left(ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      log('Ali: $e');
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
