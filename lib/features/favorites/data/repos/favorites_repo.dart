import 'package:dartz/dartz.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/features/favorites/data/models/favorite_model.dart';

abstract class FavoritesRepo {
  Future<Either<Failure, List<FavoriteProductModel>>> addProductToFavorites(
      {required int productId});
  Future<Either<Failure, List<FavoriteProductModel>>> fetchFavoriteProducts();
  Future<Either<Failure, List<FavoriteProductModel>>>
      removeProductFromFavorites({required int favoriteId});
}
