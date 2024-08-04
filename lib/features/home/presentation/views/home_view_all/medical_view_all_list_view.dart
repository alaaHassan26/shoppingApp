import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/custom_list_view_item.dart';

class MedicalViewAllListView extends StatelessWidget {
  const MedicalViewAllListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetProdctsMedicalSuccess) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.prodMedical.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ProductCard(productModel: state.prodMedical[index]),
                );
              });
        } else if (state is GetProdctsMedicalFaliure) {
          return const Text('Erorr');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
