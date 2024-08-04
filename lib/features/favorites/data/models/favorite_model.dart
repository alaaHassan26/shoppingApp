import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

class FavoriteProductModel {
  final int id;
  final ProductModel product;

  FavoriteProductModel({required this.id, required this.product});

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
    };
  }

  ProductModel toProductModel() {
    return ProductModel(
      id: product.id,
      price: product.price,
      oldPrice: product.oldPrice,
      discount: product.discount,
      image: product.image,
      name: product.name,
      description: product.description,
      inFavorites: product.inFavorites,
      images: product.images,
    );
  }
}
