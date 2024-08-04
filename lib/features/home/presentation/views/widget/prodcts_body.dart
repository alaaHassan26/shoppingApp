import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/features/home/presentation/views/widget/prodcts_electronic_devices.dart';
import 'package:shoping/features/home/presentation/views/widget/my_card_section.dart';
import 'package:shoping/features/home/presentation/views/widget/prodcts_medical.dart';
import 'package:shoping/features/home/presentation/views/widget/prodcts_new.dart';
import 'package:shoping/features/home/presentation/views/widget/prodcts_sports.dart';
import 'package:shoping/features/home/presentation/views/widget/products_clothes.dart';

class ProdctsBody extends StatelessWidget {
  const ProdctsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyCardSection(),
          const SizedBox(
            height: 8,
          ),
          ProdctsNew(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kNewViewAll);
            },
            title: AppLocalizations.of(context)!.translate('new'),
            subTitle: AppLocalizations.of(context)!
                .translate('youveneverseenitbefore'),
            trailing: AppLocalizations.of(context)!.translate('viewall'),
          ),
          const SizedBox(
            height: 12,
          ),
          ProdctsElectronicDevices(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kEletroinDeviecsViewAll);
            },
            title:
                AppLocalizations.of(context)!.translate('electrionicdevices'),
            trailing: AppLocalizations.of(context)!.translate('viewall'),
            subTitle: ' ',
          ),
          const SizedBox(
            height: 12,
          ),
          ProdctsMedical(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kMedicalViewAll);
            },
            title: AppLocalizations.of(context)!.translate('medical'),
            trailing: AppLocalizations.of(context)!.translate('viewall'),
            subTitle: ' ',
          ),
          const SizedBox(
            height: 12,
          ),
          ProdctsSports(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSportsViewAll);
            },
            title: AppLocalizations.of(context)!.translate('sports'),
            trailing: AppLocalizations.of(context)!.translate('viewall'),
            subTitle: ' ',
          ),
          const SizedBox(
            height: 12,
          ),
          ProdctsClothes(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kClothesViewAll);
            },
            title: AppLocalizations.of(context)!.translate('clothes'),
            trailing: AppLocalizations.of(context)!.translate('viewall'),
            subTitle: '  ',
          ),
        ],
      ),
    );
  }
}
