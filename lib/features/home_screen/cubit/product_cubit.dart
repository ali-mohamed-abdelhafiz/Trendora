import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home_screen/models/product_model.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._homeRepo) : super(ProductInitial());
  final HomeRepo _homeRepo;

  void fetchProducts({
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
    emit(ProductLoading());

    final response = await _homeRepo.getProducts(
      searchTerm: searchTerm,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      isInStock: isInStock,
      sortBy: sortBy,
      sortOrder: sortOrder,
      page: page,
      pageSize: pageSize,
    );

    response.fold((left) => emit(ProductError(left)),
        (right) => emit(ProductSuccess(right)));
  }
}
