import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tendora/core/networking/api_endpoints.dart';
import 'package:tendora/core/networking/api_error_handler.dart';
import 'package:tendora/core/networking/dio_helper.dart';
import 'package:tendora/features/home_screen/models/category_model.dart';
import 'package:tendora/features/home_screen/models/product_model.dart';

class HomeRepo {
  final DioHelper _dioHelper;

  HomeRepo(this._dioHelper);

  Future<Either<String, List<CategoryData>>> getCategories() async {
    try {
      Response response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.categoriesEndpoint,
      );
      if (response.statusCode == 200) {
        final data = CategoryModel.fromJson(response.data);

        return Right(data.categories);
      } else {
        return const Left('Something Went Wrong');
      }
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler2.handle(e));
    }
  }

  Future<Either<String, List<ProductData>>> getProducts({
    String searchTerm = '',
    String category = '',
    int minPrice = 0,
    int maxPrice = 0,
    bool isInStock = false,
    String sortBy = '',
    String sortOrder = '',
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      Response response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.productsEndpoint,
        query: {
          if (searchTerm.isNotEmpty) "searchTerm": searchTerm,
          if (category.isNotEmpty) "category": category,
          if (minPrice > 0) "minPrice": minPrice,
          if (maxPrice > 0) "maxPrice": maxPrice,
          "isInStock": isInStock,
          if (sortBy.isNotEmpty) "sortBy": sortBy,
          if (sortOrder.isNotEmpty) "sortOrder": sortOrder,
          "page": page,
          "pageSize": pageSize,
        },
      );
      if (response.statusCode == 200) {
        final data = ProductsModel.fromJson(response.data);
        return Right(data.items);
      } else {
        return const Left('Something Went Wrong');
      }
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler2.handle(e));
    }
  }
}
