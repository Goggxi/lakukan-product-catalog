import 'package:lakukan_product_catalog/domain/entites/paging_entity.dart';
import 'package:lakukan_product_catalog/domain/entites/product_entity.dart';
import 'package:lakukan_product_catalog/utils/result.dart';

abstract class ProductRepository {
  Future<Result<PagingEntity<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  });
  Future<Result<ProductEntity>> getProductById({
    required String id,
  });
  Future<Result<ProductEntity>> searchProduct({
    required String query,
  });
  Future<Result<List<String>>> getCategories();
}
