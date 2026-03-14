import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tendora/features/home_screen/models/category_model.dart';
import 'package:tendora/features/home_screen/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._homeRepo) : super(CategoryInitial());
  final HomeRepo _homeRepo;

  void fetchCategories() async {
    emit(CategoryLoading());
    final Either<String, List<CategoryData>> response =
        await _homeRepo.getCategories();
    response.fold((error) => emit(CategoryError(error)), (right) {
      right.insert(
          0,
          CategoryData(
              id: '0', name: 'All', description: '', coverPictureUrl: ''));
      emit(CategorySuccess(right));
    });
  }
}
