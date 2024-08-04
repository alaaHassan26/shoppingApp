import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/user/data/models/custom_item_model/custom_item_model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.customItemModel,
  });

  final CustomItemModel customItemModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FittedBox(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.scaleDown,
        child: Text(
          customItemModel.textTitle,
          style: AppStyles.styleSemiBold18(context),
        ),
      ),
      subtitle: FittedBox(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.scaleDown,
        child: Text(
          customItemModel.textSubTitle,
          style: AppStyles.styleSemiBold16(context),
        ),
      ),
      trailing: customItemModel.trailing,
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomItemModel> items = [
      CustomItemModel(
          textTitle: AppLocalizations.of(context)!.translate('myorders'),
          textSubTitle: AppLocalizations.of(context)!.translate('12_orders'),
          trailing: const Icon(Iconsax.arrow_right)),
      CustomItemModel(
          textTitle:
              AppLocalizations.of(context)!.translate('shippingaddresses'),
          textSubTitle: AppLocalizations.of(context)!.translate('3_addresses'),
          trailing: const Icon(Iconsax.arrow_right)),
      CustomItemModel(
          textTitle: AppLocalizations.of(context)!.translate('paymentmethods'),
          textSubTitle: AppLocalizations.of(context)!.translate('visa_3'),
          trailing: const Icon(Iconsax.arrow_right)),
      CustomItemModel(
          textTitle: AppLocalizations.of(context)!.translate('setting'),
          textSubTitle:
              AppLocalizations.of(context)!.translate('notifications_password'),
          trailing: const Icon(Iconsax.arrow_right)),
    ];

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToPage(context, index);
            },
            child: CustomListTile(
              customItemModel: items[index],
            ),
          );
        });
  }
}

void _navigateToPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      GoRouter.of(context).push(AppRouter.kPaymentView);
      break;
    case 1:
      GoRouter.of(context).push(AppRouter.kPaymentView);
      break;
    case 2:
      GoRouter.of(context).push(AppRouter.kPaymentView);
      break;
    case 3:
      GoRouter.of(context).push(AppRouter.kSettingView);
      break;
  }
}
