import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';
import 'package:shoping/core/functions/favorite_icon_button.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/snak_bar.dart';
import 'package:shoping/features/details/custom_details_image_list_view.dart';

import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/order/presentation/manger/cubit/cart_cubit.dart';
import 'package:shoping/features/order/presentation/views/widget/cart_page.dart';

class CustomDetailsViewItem extends StatefulWidget {
  const CustomDetailsViewItem({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<StatefulWidget> createState() => _CustomDetailsViewItemState();
}

class _CustomDetailsViewItemState extends State<CustomDetailsViewItem> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    final cubit = context.read<CartCubit>();
    final product = widget.productModel;
    product.quantity = _quantity;
    cubit.addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
      style: AppStyles.styleMedium20(context),
      message: AppLocalizations.of(context)!.translate('productaddedtocart'),
    ));
  }

  @override
  void initState() {
    context.read<CartCubit>().addToCart(widget.productModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.productModel.price! * _quantity;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: colorRed,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CartCubit(),
                    child: const CartPage(),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: CustomDatilsImageListView(
                                    productModel: widget.productModel),
                              ),
                              widget.productModel.discount == 0
                                  ? const SizedBox()
                                  : Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: colorRed,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: FittedBox(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              '${widget.productModel.discount.toString()}%',
                                              style: AppStyles.styleMedium16(
                                                  context)),
                                        ),
                                      ),
                                    ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: FavoriteIconButton(
                                    productModel: widget.productModel),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(widget.productModel.name ?? '',
                                    maxLines: 4,
                                    style: AppStyles.styleBold16(context)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('description'),
                                style: AppStyles.styleMedium20(context),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ReadMoreText(
                                      '${widget.productModel.description} ',
                                      style: AppStyles.styleMedium16(context),
                                      trimMode: TrimMode.Line,
                                      trimLines: 7,
                                      colorClickableText: Colors.pink,
                                      trimCollapsedText:
                                          AppLocalizations.of(context)!
                                              .translate('showmore'),
                                      trimExpandedText:
                                          AppLocalizations.of(context)!
                                              .translate('showless'),
                                      moreStyle:
                                          AppStyles.styleBold16(context)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: isDarkMode ? Colors.black12 : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: _decrementQuantity,
                              icon: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.remove,
                                    color: colorRed,
                                  )),
                            ),
                            Text(
                              '$_quantity',
                              style: AppStyles.styleSemiBold18(context),
                            ),
                            IconButton(
                              onPressed: _incrementQuantity,
                              icon: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.add,
                                    color: colorRed,
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            widget.productModel.discount == 0
                                ? const SizedBox()
                                : FittedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        '\$${widget.productModel.oldPrice.toString()}',
                                        style: AppStyles.styleBold16(context)
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: colorRed)),
                                  ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                FittedBox(
                                  alignment: AlignmentDirectional.centerStart,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('pirce'),
                                      style: AppStyles.styleBold16(context)),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                FittedBox(
                                  alignment: AlignmentDirectional.centerStart,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      '\$${widget.productModel.price.toString()}',
                                      style: AppStyles.styleBold16(context)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: isDarkMode ? Colors.black12 : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('totalprice'),
                                  style:
                                      AppStyles.styleBold16(context).copyWith(),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${totalPrice.toStringAsFixed(2)}\$',
                                  style: AppStyles.styleBold16(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _addToCart,
                          child: Row(
                            children: [
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.shopping_cart,
                                color: colorRed,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('addtocart'),
                                style: AppStyles.styleBold16(context)
                                    .copyWith(color: colorRed),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
