import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/medical_view_all_list_view.dart';

class MedicalViewAll extends StatelessWidget {
  const MedicalViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('medical'),
          style: AppStyles.styleSemiBold22nocolor(context),
        ),
      ),
      body: const SafeArea(child: MedicalViewAllListView()),
    );
  }
}
