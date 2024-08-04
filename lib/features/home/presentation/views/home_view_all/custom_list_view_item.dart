import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/functions/favorite_icon_button.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push(AppRouter.kCustomDetailsViewItem, extra: productModel);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            child: Card(
              color: isDarkMode ? Colors.black : Colors.white,
              elevation: .4,
              child: Container(
                height: MediaQuery.of(context).size.height * .26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: CustomCategoriesImage(
                        image: productModel.image ?? '',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(productModel.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.styleSemiBold18(context)),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            productModel.discount == 0
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      FittedBox(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('discount'),
                                          style: AppStyles.styleBold16(context),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      FittedBox(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          productModel.discount.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 8),
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
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              productModel.oldPrice.toString(),
                                              style: AppStyles.styleRegular16(
                                                      context)
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: colorRed),
                                            ),
                                          ),
                                    FittedBox(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        productModel.price.toString(),
                                        style:
                                            AppStyles.styleRegular16(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FavoriteIconButton(
                                  productModel: productModel,
                                ),
                              ],
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
        ),
        const Divider(
          color: colorRed,
        )
      ],
    );
  }
}
