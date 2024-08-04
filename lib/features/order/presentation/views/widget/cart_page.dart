import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';

import 'package:shoping/features/order/presentation/manger/cubit/cart_cubit.dart';
import 'package:shoping/features/order/presentation/views/widget/cart_buttom_item.dart';
import 'package:shoping/features/order/presentation/views/widget/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.translate('shoppingcart'),
            style: AppStyles.styleSemiBold24(context),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartUpdated) {
              final cartItems = state.cartItems;

              if (cartItems.isEmpty) {
                return Center(
                    child: Text(
                  AppLocalizations.of(context)!.translate('yourcartisempty'),
                  style: AppStyles.styleSemiBold22(context),
                ));
              }

              double totalAmount = cartItems.fold(
                0,
                (sum, item) => sum + (item.price! * item.quantity),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        final double totalPrice =
                            product.price! * product.quantity;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: isDarkMode ? Colors.black12 : Colors.white,
                              elevation: .4,
                              child: CartItem(
                                  product: product, totalPrice: totalPrice)),
                        );
                      },
                    ),
                  ),
                  CartButtomItem(totalAmount: totalAmount),
                  const SizedBox(
                    height: 8,
                  )
                ],
              );
            } else if (state is CartInitial) {
              return Center(
                  child: Text(
                AppLocalizations.of(context)!.translate('yourcartisempty'),
                style: AppStyles.styleSemiBold22(context),
              ));
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}
