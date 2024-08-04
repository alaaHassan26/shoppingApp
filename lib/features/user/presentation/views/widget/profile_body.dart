import 'package:flutter/material.dart';
import 'package:shoping/core/functions/direction_arabic.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/user/presentation/views/widget/custom_listtitle.dart';
import 'package:shoping/features/user/presentation/views/widget/log_out_body.dart';
import 'package:shoping/features/user/presentation/views/widget/user_info_listtile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isArabic(context) ? 16 : 16,
          right: isArabic(context) ? 16 : 16,
          top: 40,
          bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate('myprofile'),
            style: AppStyles.styleSemiBold34(context),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: isArabic(context) ? 0 : 10,
              right: isArabic(context) ? 10 : 0,
            ),
            child: const UserInfoListTile(),
          ),
          const SizedBox(
            height: 15,
          ),
          const ProfileItem(),
          const Spacer(),
          const LogoutBody(),
        ],
      ),
    );
  }
}
