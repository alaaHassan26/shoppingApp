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

class FavoriteIconButton extends StatefulWidget {
  final ProductModel productModel;

  const FavoriteIconButton({super.key, required this.productModel});

  @override
  State<StatefulWidget> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    setState(() {
      widget.productModel.inFavorites = CacheHelper()
              .getDataString(key: 'isFavorite_${widget.productModel.id}') ==
          'true'; // Check if the value is 'true'
    });
  }

  void _addFavorite() async {
    if (widget.productModel.inFavorites) {
      ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
        style: AppStyles.styleMedium20(context),
        message: AppLocalizations.of(context)!
            .translate('theproductisalreadyaddedtofavorites'),
      ));
      return;
    }

    setState(() {
      widget.productModel.inFavorites = true;
    });

    await CacheHelper()
        .saveData(key: 'isFavorite_${widget.productModel.id}', value: 'true');

    BlocProvider.of<FavoriteCubit>(context)
        .addProductToFavorites(widget.productModel.id!);

    ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
      style: AppStyles.styleMedium20(context),
      message: AppLocalizations.of(context)!
          .translate('theproducthasbeenaddedtofavorites'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addFavorite,
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
          widget.productModel.inFavorites
              ? Icons.favorite
              : Icons.favorite_border,
          color: widget.productModel.inFavorites ? colorRed : Colors.grey,
        ),
      ),
    );
  }
}
