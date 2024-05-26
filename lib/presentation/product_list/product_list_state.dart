part of 'product_list_bloc.dart';

@immutable
sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListSuccess extends ProductListState {
  final Result<PagingEntity<ProductEntity>> result;

  ProductListSuccess(this.result);
}

final class ProductListError extends ProductListState {
  final String message;
  final int code;

  ProductListError(this.message, {this.code = 0});
}
