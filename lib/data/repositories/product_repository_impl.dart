import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:lakukan_product_catalog/data/models/product_model.dart';
import 'package:lakukan_product_catalog/domain/entites/paging_entity.dart';
import 'package:lakukan_product_catalog/domain/entites/product_entity.dart';
import 'package:lakukan_product_catalog/domain/repositories/product_repository.dart';
import 'package:lakukan_product_catalog/utils/constants.dart';
import 'package:lakukan_product_catalog/utils/http_client.dart';
import 'package:lakukan_product_catalog/utils/result.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final HttpClient _httpClient;
  final Logger _logger;

  ProductRepositoryImpl(this._httpClient, this._logger);

  @override
  Future<Result<ProductEntity>> getProductById({required String id}) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Result<PagingEntity<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  }) async {
    const path = '/products';
    final Map<String, dynamic> queryParameters = {
      'limit': limit,
      'skip': skip,
    };

    try {
      _logger.t('GET $path');
      final response = await _httpClient.apiRequest(
        url: Constants.baseUrl,
        apiPath: path,
        method: RequestMethod.get,
        queryParameter: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = response.body;
        final decode = jsonDecode(data);
        final int total = decode['total'];
        final int skip = decode['skip'];
        final int limit = decode['limit'];
        final List<ProductModel> products = (decode['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        _logger.d("Success : ${response.statusCode}");
        return Result.success(
          PagingEntity<ProductEntity>(
            list: products,
            total: total,
            skip: skip,
            limit: limit,
          ),
        );
      }

      _logger.e('GET $path Body:${response.body}');
      return Result.error(
        code: response.statusCode,
      );
    } catch (e) {
      _logger.e(e.toString());
      return Result.error(message: e.toString());
    }
  }

  @override
  Future<Result<ProductEntity>> searchProduct({required String query}) {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>>> getCategories() async {
    const path = '/products/category-list';

    try {
      _logger.t('GET $path');
      final response = await _httpClient.apiRequest(
        url: Constants.baseUrl,
        apiPath: path,
        method: RequestMethod.get,
      );

      if (response.statusCode == 200) {
        final data = response.body;
        final decode = jsonDecode(data);
        final List<String> categories =
            (decode as List).map((e) => e.toString()).toList();
        _logger.d("Success : ${response.statusCode}");
        return Result.success(categories);
      }

      _logger.e('GET $path Body:${response.body}');
      return Result.error(
        code: response.statusCode,
      );
    } catch (e) {
      _logger.e(e.toString());
      return Result.error(message: e.toString());
    }
  }
}
