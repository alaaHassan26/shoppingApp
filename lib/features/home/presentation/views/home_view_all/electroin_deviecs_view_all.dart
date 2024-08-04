import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/electroin_deviecs_view_all_list_view.dart';

class EletroinDeviecsViewAll extends StatelessWidget {
  const EletroinDeviecsViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('electrionicdevices'),
          style: AppStyles.styleSemiBold22nocolor(context),
        ),
      ),
      body: const SafeArea(child: EletroinDeviecsViewAllListView()),
    );
  }
}
