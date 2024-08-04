import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shoping/features/favorites/data/repos/favorites_repo.dart';
import 'package:shoping/features/favorites/data/models/favorite_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoritesRepo favoritesRepo;

  FavoriteCubit(this.favoritesRepo) : super(FavoriteInitial());

  void addProductToFavorites(int productId) async {
    emit(FavoriteLoading());
    final Either<Failure, List<FavoriteProductModel>> result =
        await favoritesRepo.addProductToFavorites(productId: productId);

    result.fold(
      (failure) => emit(FavoriteError(message: failure.errMessage)),
      (favoriteProducts) => emit(FavoriteAdded(favoriteProducts)),
    );

    fetchFavoriteProducts(); // إعادة جلب المنتجات المفضلة لتحديث القائمة
  }

  void fetchFavoriteProducts() async {
    emit(FavoriteLoading());
    final Either<Failure, List<FavoriteProductModel>> result =
        await favoritesRepo.fetchFavoriteProducts();

    result.fold(
      (failure) => emit(FavoriteError(message: failure.errMessage)),
      (favoriteProducts) => emit(FavoriteLoaded(favoriteProducts)),
    );
  }

  void removeProductFromFavorites(int favoriteId) async {
    emit(FavoriteLoading());
    final Either<Failure, List<FavoriteProductModel>> result =
        await favoritesRepo.removeProductFromFavorites(favoriteId: favoriteId);

    result.fold(
      (failure) => emit(FavoriteError(message: failure.errMessage)),
      (favoriteProducts) => emit(FavoriteLoaded(favoriteProducts)),
    );
  }
}
