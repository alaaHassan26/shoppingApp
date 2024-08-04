import 'package:flutter/material.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

import 'package:shoping/features/home/presentation/views/widget/custom_categories_listview_item.dart';

class CustomCategoriesListView extends StatelessWidget {
  const CustomCategoriesListView(
      {super.key, required this.height, required this.products});
  final List<ProductModel> products;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomCategoriesListViewItem(
                    productModel: products[index],
                  ));
            }),
      ),
    );
  }
}
