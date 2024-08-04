import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

import 'package:shoping/features/shop/presentation/view/widget/products_item_card.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_shop_clothes.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_shop_electronic.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_shop_medical.dart';
import 'package:shoping/features/shop/presentation/view/widget/products_shop_sports.dart';

class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({
    super.key,
    required this.isSearching,
    required this.filteredProducts,
    required TabController tabController,
  }) : _tabController = tabController;

  final bool isSearching;
  final List<ProductModel> filteredProducts;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isSearching
          ? filteredProducts.isNotEmpty
              ? MasonryGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductsItemCard(
                      productModel: filteredProducts[index],
                    );
                  },
                )
              : const Center(child: Text('No products found'))
          : TabBarView(
              controller: _tabController,
              children: const [
                ProductsShopElectronic(),
                ProductsShopSports(),
                ProductsShopClothes(),
                ProductsShopMedical(),
              ],
            ),
    );
  }
}
