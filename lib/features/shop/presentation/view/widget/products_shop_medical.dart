import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';

class ProductsShopMedical extends StatefulWidget {
  const ProductsShopMedical({super.key});

  @override
  State<ProductsShopMedical> createState() => _ProductsShopMedicalState();
}

class _ProductsShopMedicalState extends State<ProductsShopMedical> {
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().getProdctsMedical(num: 43);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is GetProdctsMedicalSuccess) {
        products.addAll(state.prodMedical);
      }
      if (state is GetProdctsMedicalFaliure) {
        const Text('Eroor');
      }
      if (state is GetProdctsMedicalLoading) {
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
