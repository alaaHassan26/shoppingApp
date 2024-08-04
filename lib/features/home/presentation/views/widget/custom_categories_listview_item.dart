import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:shoping/core/functions/favorite_icon_button.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';

import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

class CustomCategoriesListViewItem extends StatelessWidget {
  const CustomCategoriesListViewItem({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.kCustomDetailsViewItem, extra: productModel);
      },
      child: Card(
        color: isDarkMode ? Colors.black : Colors.white,
        elevation: .4,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CustomCategoriesImage(
                        image: productModel.image ?? '',
                        width: MediaQuery.of(context).size.width * .999,
                        height: MediaQuery.of(context).size.width * .8,
                      ),
                    ),
                    productModel.discount == 0
                        ? const SizedBox()
                        : Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorRed,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${productModel.discount.toString()}%',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: FavoriteIconButton(
                          productModel: productModel,
                        )),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(productModel.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.styleSemiBold18(context)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          FittedBox(
                            alignment: AlignmentDirectional.centerStart,
                            fit: BoxFit.scaleDown,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('pirce'),
                                style: AppStyles.styleSemiBold18(context)
                                    .copyWith(color: colorRed)),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              productModel.discount == 0
                                  ? const SizedBox()
                                  : FittedBox(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${productModel.oldPrice.toString()}\$',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyles.styleRegular16(context)
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: colorRed),
                                      ),
                                    ),
                              FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${productModel.price.toString()}\$',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.styleRegular16(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Assuming you have a ProductModel class

