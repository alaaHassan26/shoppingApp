import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';
import 'package:shoping/features/order/presentation/manger/cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product, required this.totalPrice});
  final ProductModel product;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: CustomCategoriesImage(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.2,
                    image: product.image ?? '',
                  ),
                )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(product.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.styleMedium20(context)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        FittedBox(
                          alignment: AlignmentDirectional.centerStart,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppLocalizations.of(context)!.translate('pirce'),
                            style: AppStyles.styleMedium16(context),
                          ),
                        ),
                        FittedBox(
                          alignment: AlignmentDirectional.centerStart,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ': \$${product.price!.toStringAsFixed(2)}',
                            style: AppStyles.styleMedium16(context),
                          ),
                        ),
                      ],
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
                                  .translate('totalprice'),
                              style: AppStyles.styleMedium16(context)),
                        ),
                        FittedBox(
                          alignment: AlignmentDirectional.centerStart,
                          fit: BoxFit.scaleDown,
                          child: Text(': \$${totalPrice.toStringAsFixed(2)}',
                              style: AppStyles.styleMedium16(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: colorRed,
              ),
              onPressed: () {
                context.read<CartCubit>().removeFromCart(product);
              },
            ),
            IconButton(
              icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.remove,
                    color: colorRed,
                  )),
              onPressed: () {
                context.read<CartCubit>().decreaseQuantity(product);
              },
            ),
            Text(
              '${product.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.add,
                    color: colorRed,
                  )),
              onPressed: () {
                context.read<CartCubit>().increaseQuantity(product);
              },
            ),
          ],
        ),
      ],
    );
  }
}
