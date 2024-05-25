import 'package:lakukan_product_catalog/domain/entites/paging_entity.dart';
import 'package:lakukan_product_catalog/domain/entites/product_entity.dart';
import 'package:lakukan_product_catalog/utils/result.dart';

abstract class ProductRepository {
  Future<Result<PagingEntity<ProductEntity>>> getProducts({
    required final int limit,
  });
  Future<Result<ProductEntity>> getProductById({
    required final String id,
  });
  Future<Result<ProductEntity>> searchProduct({
    required final String query,
  });
}
