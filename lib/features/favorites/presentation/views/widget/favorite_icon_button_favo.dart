// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/cache/cache_helper.dart';

import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/snak_bar.dart';
import 'package:shoping/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

class FavoriteIconButtonFavo extends StatefulWidget {
  final ProductModel productModel;

  const FavoriteIconButtonFavo({super.key, required this.productModel});

  @override
  State<StatefulWidget> createState() => _FavoriteIconButtonFavoState();
}

class _FavoriteIconButtonFavoState extends State<FavoriteIconButtonFavo> {
  final CacheHelper _cacheHelper = CacheHelper();

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    await _cacheHelper.init();
    setState(() {
      widget.productModel.inFavorites = _cacheHelper.getDataString(
              key: 'isFavorite_${widget.productModel.id}') ==
          'true';
    });
  }

  void _toggleFavorite() async {
    setState(() {
      widget.productModel.inFavorites = !widget.productModel.inFavorites;
    });

    await _cacheHelper.saveData(
        key: 'isFavorite_${widget.productModel.id}',
        value: widget.productModel.inFavorites.toString());

    if (widget.productModel.inFavorites) {
      BlocProvider.of<FavoriteCubit>(context)
          .removeProductFromFavorites(widget.productModel.id!);
      ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
        style: AppStyles.styleMedium20(context),
        message: AppLocalizations.of(context)!
            .translate('theproducthasbeenremovedfromfavorites'),
      ));
    } else {
      BlocProvider.of<FavoriteCubit>(context)
          .addProductToFavorites(widget.productModel.id!);
      ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
        style: AppStyles.styleMedium20(context),
        message: AppLocalizations.of(context)!
            .translate('theproducthasbeenremovedfromfavorites'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorite,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.delete_forever,
          color: widget.productModel.inFavorites ? colorRed : Colors.grey,
        ),
      ),
    );
  }
}
