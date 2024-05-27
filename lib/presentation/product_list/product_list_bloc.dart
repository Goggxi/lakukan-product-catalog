import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lakukan_product_catalog/domain/entites/paging_entity.dart';
import 'package:lakukan_product_catalog/domain/entites/product_entity.dart';
import 'package:lakukan_product_catalog/domain/repositories/product_repository.dart';
import 'package:lakukan_product_catalog/utils/result.dart';
import 'package:meta/meta.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

@injectable
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository _productRepository;

  ProductListBloc(this._productRepository) : super(ProductListInitial()) {
    on<GetProductListEvent>(_getProductList);
    on<GetCategoryListEvent>(_getCategoryList);
  }

  void _getProductList(
    GetProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(ProductListLoading());
    final result = await _productRepository.getProducts(
      limit: event.limit,
      skip: event.skip,
    );
    if (result.status == Status.success) {
      emit(ProductListSuccess(result));
    } else {
      emit(ProductListError(result.message, code: result.code));
    }
  }

  void _getCategoryList(
    GetCategoryListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(CategoryListLoading());
    final result = await _productRepository.getCategories();
    if (result.status == Status.success) {
      emit(CategoryListSuccess(result.data));
    } else {
      emit(CategoryListError(result.message, code: result.code));
    }
  }
}
