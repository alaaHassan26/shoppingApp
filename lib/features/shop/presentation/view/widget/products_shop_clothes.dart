import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';

class ProductsShopClothes extends StatefulWidget {
  const ProductsShopClothes({super.key});

  @override
  State<ProductsShopClothes> createState() => _ProductsShopClothesState();
}

class _ProductsShopClothesState extends State<ProductsShopClothes> {
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().getProdctsClothes(num: 46);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is GetProdctsClothesSuccess) {
        products.addAll(state.prodClothes);
      }
      if (state is GetProdctsClothesFaliure) {
        const Text('Eroor');
      }
      if (state is GetProdctsClothesLoading) {
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
