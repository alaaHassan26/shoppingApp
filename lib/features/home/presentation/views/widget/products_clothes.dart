import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_listview.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_list_title_home_view.dart';

class ProdctsClothes extends StatelessWidget {
  const ProdctsClothes({
    super.key,
    required this.title,
    this.subTitle = '',
    required this.trailing,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final String trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomListTitleHomeView(
            onTap: onTap, title: title, subTitle: subTitle, trailing: trailing),
        const CustomCategoriesListViewBloc(),
      ],
    );
  }
}

class CustomCategoriesListViewBloc extends StatefulWidget {
  const CustomCategoriesListViewBloc({
    super.key,
  });

  @override
  State<CustomCategoriesListViewBloc> createState() =>
      _CustomCategoriesListViewBlocState();
}

class _CustomCategoriesListViewBlocState
    extends State<CustomCategoriesListViewBloc> {
  final List<ProductModel> productsAlaa = [];
  @override
  void initState() {
    context.read<HomeCubit>().getProdctsClothes(num: 46);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetProdctsClothesSuccess) {
          productsAlaa.addAll(state.prodClothes);
        }
        if (state is GetProdctsClothesFaliure) {
          const Text('Eroor');
        }
        if (state is GetProdctsClothesLoading) {
          const CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        return CustomCategoriesListView(
          products: productsAlaa,
          height: MediaQuery.of(context).size.height * 0.4,
        );
      },
    );
  }
}
