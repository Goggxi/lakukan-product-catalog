import 'dart:convert';

import 'package:lakukan_product_catalog/domain/entites/product_entity.dart';

class ProductModel extends ProductEntity {
  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ProductModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json["id"] ?? "",
          title: json["title"] ?? "",
          description: json["description"] ?? "",
          category: json["category"] ?? "",
          price: json["price"]?.toDouble() ?? 0.0,
          discountPercentage: json["discountPercentage"]?.toDouble() ?? 0.0,
          rating: json["rating"]?.toDouble() ?? 0.0,
          stock: json["stock"] ?? 0,
          tags: json["tags"] != null
              ? List<String>.from(json["tags"].map((x) => x))
              : [],
          brand: json["brand"] ?? "",
          sku: json["sku"] ?? "",
          weight: json["weight"] ?? "",
          dimensions: json["dimensions"] != null
              ? DimensionsModel.fromJson(json["dimensions"]).toEntity()
              : DimensionsEntity(width: 0.0, height: 0.0, depth: 0.0),
          warrantyInformation: json["warrantyInformation"] ?? "",
          shippingInformation: json["shippingInformation"] ?? "",
          availabilityStatus: json["availabilityStatus"] ?? "",
          reviews: json["reviews"] != null
              ? List<ReviewModel>.from(
                  json["reviews"].map((x) => ReviewModel.fromJson(x)))
              : [],
          returnPolicy: json["returnPolicy"] ?? "",
          minimumOrderQuantity: json["minimumOrderQuantity"] ?? 0,
          meta: json["meta"] != null
              ? MetaModel.fromJson(json["meta"]).toEntity()
              : MetaEntity(
                  createdAt: DateTime(0),
                  updatedAt: DateTime(0),
                  barcode: "",
                  qrCode: "",
                ),
          thumbnail: json["thumbnail"] ?? "",
          images: json["images"] != null
              ? List<String>.from(json["images"].map((x) => x))
              : [],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "tags": List<dynamic>.from(tags.map((x) => x)),
      "brand": brand,
      "sku": sku,
      "weight": weight,
      "dimensions": DimensionsModel.fromEntity(dimensions).toJson(),
      "warrantyInformation": warrantyInformation,
      "shippingInformation": shippingInformation,
      "availabilityStatus": availabilityStatus,
      "reviews": List<dynamic>.from(
          reviews.map((x) => ReviewModel.fromEntity(x).toJson())),
      "returnPolicy": returnPolicy,
      "minimumOrderQuantity": minimumOrderQuantity,
      "meta": MetaModel.fromEntity(meta).toJson(),
      "thumbnail": thumbnail,
      "images": List<dynamic>.from(images.map((x) => x)),
    };
  }

  ProductModel.fromEntity(ProductEntity entity)
      : super(
          id: entity.id,
          title: entity.title,
          description: entity.description,
          category: entity.category,
          price: entity.price,
          discountPercentage: entity.discountPercentage,
          rating: entity.rating,
          stock: entity.stock,
          tags: entity.tags,
          brand: entity.brand,
          sku: entity.sku,
          weight: entity.weight,
          dimensions: DimensionsModel.fromEntity(entity.dimensions),
          warrantyInformation: entity.warrantyInformation,
          shippingInformation: entity.shippingInformation,
          availabilityStatus: entity.availabilityStatus,
          reviews:
              entity.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
          returnPolicy: entity.returnPolicy,
          minimumOrderQuantity: entity.minimumOrderQuantity,
          meta: MetaModel.fromEntity(entity.meta),
          thumbnail: entity.thumbnail,
          images: entity.images,
        );

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        description: description,
        category: category,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        tags: tags,
        brand: brand,
        sku: sku,
        weight: weight,
        dimensions: dimensions,
        warrantyInformation: warrantyInformation,
        shippingInformation: shippingInformation,
        availabilityStatus: availabilityStatus,
        reviews: reviews.map((e) => e).toList(),
        returnPolicy: returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity,
        meta: meta,
        thumbnail: thumbnail,
        images: images,
      );
}

class DimensionsModel extends DimensionsEntity {
  factory DimensionsModel.fromRawJson(String str) =>
      DimensionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  DimensionsModel.fromJson(Map<String, dynamic> json)
      : super(
          width: json["width"]?.toDouble() ?? 0.0,
          height: json["height"]?.toDouble() ?? 0.0,
          depth: json["depth"]?.toDouble() ?? 0.0,
        );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
      };

  DimensionsModel.fromEntity(DimensionsEntity entity)
      : super(
          width: entity.width,
          height: entity.height,
          depth: entity.depth,
        );

  DimensionsEntity toEntity() => DimensionsEntity(
        width: width,
        height: height,
        depth: depth,
      );
}

class MetaModel extends MetaEntity {
  factory MetaModel.fromRawJson(String str) =>
      MetaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  MetaModel.fromJson(Map<String, dynamic> json)
      : super(
          createdAt: DateTime.parse(json["createdAt"] ?? ""),
          updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
          barcode: json["barcode"] ?? "",
          qrCode: json["qrCode"] ?? "",
        );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "barcode": barcode,
        "qrCode": qrCode,
      };

  MetaModel.fromEntity(MetaEntity entity)
      : super(
          createdAt: entity.createdAt,
          updatedAt: entity.updatedAt,
          barcode: entity.barcode,
          qrCode: entity.qrCode,
        );

  MetaEntity toEntity() => MetaEntity(
        createdAt: createdAt,
        updatedAt: updatedAt,
        barcode: barcode,
        qrCode: qrCode,
      );
}

class ReviewModel extends ReviewEntity {
  ReviewModel.fromJson(Map<String, dynamic> json)
      : super(
          rating: json["rating"] ?? 0.0,
          comment: json["comment"] ?? "",
          date: DateTime.parse(json["date"] ?? ""),
          reviewerName: json["reviewerName"] ?? "",
          reviewerEmail: json["reviewerEmail"] ?? "",
        );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
      };

  factory ReviewModel.fromRawJson(String str) =>
      ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ReviewModel.fromEntity(ReviewEntity entity)
      : super(
          rating: entity.rating,
          comment: entity.comment,
          date: entity.date,
          reviewerName: entity.reviewerName,
          reviewerEmail: entity.reviewerEmail,
        );

  ReviewEntity toEntity() => ReviewEntity(
        rating: rating,
        comment: comment,
        date: date,
        reviewerName: reviewerName,
        reviewerEmail: reviewerEmail,
      );
}
