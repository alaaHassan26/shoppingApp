import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/favorites/data/models/favorite_model.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_icon_button_favo.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

class FavoriteProductItem extends StatelessWidget {
  const FavoriteProductItem({
    super.key,
    required this.favoriteProduct,
  });

  final FavoriteProductModel favoriteProduct;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // GoRouter.of(context)
        //     .push(AppRouter.kCustomDetailsViewItem, extra: favoriteProduct);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: Card(
          color: isDarkMode ? Colors.black12 : Colors.white,
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
                    image: favoriteProduct.product.image ??
                        '', // استبدل برابط الصورة الفعلي
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
                          child: Text(favoriteProduct.product.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.styleSemiBold18(context)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const FittedBox(
                              alignment: AlignmentDirectional.centerStart,
                              fit: BoxFit.scaleDown,
                              child: Text('Discount'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            FittedBox(
                              alignment: AlignmentDirectional.centerStart,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                favoriteProduct.product.discount.toString(),
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
                            FittedBox(
                              alignment: AlignmentDirectional.centerStart,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                ' ${favoriteProduct.product.price.toString()} \$',
                                style: AppStyles.styleRegular16(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FavoriteIconButtonFavo(
                              productModel: favoriteProduct.product,
                            ),
                          ],
                        ) //
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
