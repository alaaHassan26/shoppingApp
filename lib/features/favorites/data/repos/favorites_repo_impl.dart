import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shoping/core/api/api_consumer.dart';
import 'package:shoping/core/api/end_ponits.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/features/favorites/data/models/favorite_model.dart';
import 'package:shoping/features/favorites/data/repos/favorites_repo.dart';

class FavoritesRepoImpl extends FavoritesRepo {
  final ApiConsumer apiConsumer;

  FavoritesRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, List<FavoriteProductModel>>> addProductToFavorites(
      {required int productId}) async {
    try {
      await apiConsumer.post(
        EndPonit.favorites,
        isFormData: true,
        data: {'product_id': productId},
      );
      return await fetchFavoriteProducts();
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteProductModel>>>
      fetchFavoriteProducts() async {
    try {
      final response = await apiConsumer.get(EndPonit.favorites);
      final List<FavoriteProductModel> favoriteProducts =
          (response['data']['data'] as List)
              .map((product) => FavoriteProductModel.fromJson(product))
              .toList();
      return right(favoriteProducts);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteProductModel>>>
      removeProductFromFavorites({required int favoriteId}) async {
    try {
      final response = await apiConsumer
          .delete('${EndPonit.favorites}/$favoriteId', isFormData: true);
      if (response['status'] == true) {
        return await fetchFavoriteProducts();
      } else {
        return left(ServerFailure('Failed to delete favorite'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
