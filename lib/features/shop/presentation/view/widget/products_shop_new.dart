import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';

class ProductsShopNew extends StatefulWidget {
  const ProductsShopNew({super.key});

  @override
  State<ProductsShopNew> createState() => _ProductsShopNewState();
}

class _ProductsShopNewState extends State<ProductsShopNew> {
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().getProdctsNew(num: 40);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is GetProdctsNewuccess) {
        products.addAll(state.prodNew);
      }
      if (state is GetProdctsNewFaliure) {
        const Text('Eroor');
      }
      if (state is GetProdctsNewLoading) {
        const CircularProgressIndicator();
      }
    }, builder: (context, state) {
      return MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductsItemCard(
            productModel: products[index],
          );
        },
      );
    });
  }
}
