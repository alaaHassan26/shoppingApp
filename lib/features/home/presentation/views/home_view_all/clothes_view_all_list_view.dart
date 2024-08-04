import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/custom_list_view_item.dart';

class ClothesViewAllListView extends StatelessWidget {
  const ClothesViewAllListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetProdctsClothesSuccess) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.prodClothes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ProductCard(productModel: state.prodClothes[index]),
                );
              });
        } else if (state is GetProdctsClothesFaliure) {
          return const Text('Erorr');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
