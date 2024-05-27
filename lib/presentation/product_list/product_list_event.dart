part of 'product_list_bloc.dart';

@immutable
sealed class ProductListEvent {}

class GetProductListEvent extends ProductListEvent {
  final int limit;
  final int skip;

  GetProductListEvent({this.limit = 10, this.skip = 0});
}

class GetCategoryListEvent extends ProductListEvent {}
