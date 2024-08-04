import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';

class ProductsShopSports extends StatefulWidget {
  const ProductsShopSports({super.key});

  @override
  State<ProductsShopSports> createState() => _ProductsShopSportsState();
}

class _ProductsShopSportsState extends State<ProductsShopSports> {
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().getProdctsSports(num: 42);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is GetProdctsSportsSuccess) {
        products.addAll(state.prodSports);
      }
      if (state is GetProdctsSportsFaliure) {
        const Text('Eroor');
      }
      if (state is GetProdctsSportsLoading) {
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
