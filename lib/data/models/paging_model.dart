import 'dart:convert';

class PagingModel {
  final List<dynamic> products;
  final int total;
  final int skip;
  final int limit;

  PagingModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  PagingModel copyWith({
    List<dynamic>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      PagingModel(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory PagingModel.fromRawJson(String str) =>
      PagingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PagingModel.fromJson(Map<String, dynamic> json) => PagingModel(
        products: List<dynamic>.from(json["products"].map((x) => x)),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x)),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
