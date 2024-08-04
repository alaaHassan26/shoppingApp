import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_listview.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_list_title_home_view.dart';

class ProdctsElectronicDevices extends StatelessWidget {
  const ProdctsElectronicDevices({
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
  final List<ProductModel> productEl = [];
  @override
  void initState() {
    context.read<HomeCubit>().getProdctsElectronicDevices(num: 44);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetProdctsElectronicDevicesSuccess) {
          productEl.addAll(state.prodElectronic);
        }
        if (state is GetProdctsElectronicDevicesFaliure) {
          const Text('Eroor');
        }
        if (state is GetProdctsElectronicDevicesLoading) {
          const CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        return CustomCategoriesListView(
          products: productEl,
          height: MediaQuery.of(context).size.height * 0.4,
        );
      },
    );
  }
}
