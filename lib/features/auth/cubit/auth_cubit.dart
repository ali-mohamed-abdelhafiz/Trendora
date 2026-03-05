import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/features/auth/model/error_model.dart';
import 'package:ecommerce_app/features/auth/model/login_model.dart';
import 'package:ecommerce_app/features/auth/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;

  void login({required String email, required String password}) async {
    emit(AuthLoadingState());

    final Either<ErrorModel, LoginModel> res =
        await _authRepo.login(email, password);
    res.fold(
        (error) =>
            emit(AuthFailureState(error.errors.entries.first.value.first)),
        (right) async {
      await getIt<StorageHelper>().saveAccessToken(right.accessToken);
      await getIt<StorageHelper>().saveRefreshToken(right.refreshToken);

      emit(AuthSuccesState('Login Successfully'));
    });
  }
}
