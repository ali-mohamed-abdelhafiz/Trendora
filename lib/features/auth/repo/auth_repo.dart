import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/api_error_handler.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/auth/model/error_model.dart';
import 'package:ecommerce_app/features/auth/model/login_model.dart';

class AuthRepo {
  final DioHelper _dioHelper;

  AuthRepo(this._dioHelper);

  Future<Either<ErrorModel, LoginModel>> login(
      String email, String password) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.loginEndpoint,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(LoginModel.fromJson(response.data));
      } else {
        return Left(ErrorModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      return Left(ApiErrorHandler.handle(e));
    } catch (e) {
      return Left(ErrorModel(
        statusCode: 0,
        message: e.toString(),
        errors: {},
      ));
    }
  }
}
