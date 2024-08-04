import 'package:shoping/core/api/end_ponits.dart';

class ProductModel {
  final int? id;
  final double? price;
  final double? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;
  bool inFavorites;
  final List<String>? images;
  int quantity;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.images,
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ApiKey.id] as int?,
      price: (json[ApiKey.price] as num?)?.toDouble(),
      oldPrice: (json['old_price'] as num?)?.toDouble(),
      discount: json[ApiKey.discount] as int?,
      image: json[ApiKey.image] as String?,
      name: json[ApiKey.name] as String?,
      description: json['description'] as String?,
      inFavorites: json['in_favorites'] as bool? ?? false,
      images: (json['images'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.price: price,
      'old_price': oldPrice,
      ApiKey.discount: discount,
      ApiKey.image: image,
      ApiKey.name: name,
      'description': description,
      'in_favorites': inFavorites,
      'images': images,
      'quantity': quantity,
    };
  }
}
