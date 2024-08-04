import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/clothes_view_all_list_view.dart';

class ClothesViewAll extends StatelessWidget {
  const ClothesViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('clothes'),
          style: AppStyles.styleSemiBold22nocolor(context),
        ),
      ),
      body: const SafeArea(child: ClothesViewAllListView()),
    );
  }
}
