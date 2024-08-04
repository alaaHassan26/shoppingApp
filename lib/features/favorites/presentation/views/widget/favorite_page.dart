import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';

import 'package:shoping/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_product_item.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_product_item_shimmer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<FavoriteCubit>().fetchFavoriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: ShimmerBestSeller());
        } else if (state is FavoriteLoaded) {
          if (state.favoriteProducts.isEmpty) {
            return Center(
                child: Text(
              AppLocalizations.of(context)!.translate('nofavorite'),
              style: AppStyles.styleSemiBold24(context),
            ));
          }

          return ListView.builder(
            itemCount: state.favoriteProducts.length,
            itemBuilder: (context, index) {
              final favoriteProduct = state.favoriteProducts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FavoriteProductItem(favoriteProduct: favoriteProduct),
              );
            },
          );
        } else if (state is FavoriteError) {
          return Center(child: Text(state.message));
        } else {
          return Center(
              child: Text(
            AppLocalizations.of(context)!.translate('nofavorite'),
            style: AppStyles.styleSemiBold24(context),
          ));
        }
      },
    );
  }
}
