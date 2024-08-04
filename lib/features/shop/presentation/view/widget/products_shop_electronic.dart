import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';

class ProductsShopElectronic extends StatefulWidget {
  const ProductsShopElectronic({super.key});

  @override
  State<ProductsShopElectronic> createState() => _ProductsShopElectronicState();
}

class _ProductsShopElectronicState extends State<ProductsShopElectronic> {
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().getProdctsElectronicDevices(num: 44);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(listener: (context, state) {
      if (state is GetProdctsElectronicDevicesSuccess) {
        products.addAll(state.prodElectronic);
      }
      if (state is GetProdctsElectronicDevicesFaliure) {
        const Text('Eroor');
      }
      if (state is GetProdctsElectronicDevicesLoading) {
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
