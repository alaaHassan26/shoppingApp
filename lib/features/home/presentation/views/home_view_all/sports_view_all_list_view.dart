import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/custom_list_view_item.dart';

class SportsViewAllListView extends StatelessWidget {
  const SportsViewAllListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetProdctsSportsSuccess) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.prodSports.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ProductCard(productModel: state.prodSports[index]),
                );
              });
        } else if (state is GetProdctsSportsFaliure) {
          return const Text('Erorr');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
