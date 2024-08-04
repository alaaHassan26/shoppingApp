part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteAdded extends FavoriteState {
  final List<FavoriteProductModel> favoriteProduct;

  FavoriteAdded(this.favoriteProduct);
}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteProductModel> favoriteProducts;

  FavoriteLoaded(this.favoriteProducts);
}

class FavoriteRemoved extends FavoriteState {
  final int favoriteId;

  FavoriteRemoved(this.favoriteId);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}
