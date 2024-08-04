import 'package:flutter/material.dart';
import 'package:shoping/core/utils/appstyles.dart';

class CustomListTitleHomeView extends StatelessWidget {
  const CustomListTitleHomeView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailing,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final String trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FittedBox(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: AppStyles.styleSemiBold18(context),
        ),
      ),
      subtitle: FittedBox(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.scaleDown,
        child: Text(
          subTitle,
          style: AppStyles.styleSemiBold16(context),
        ),
      ),
      trailing: FittedBox(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.scaleDown,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            trailing,
            style: AppStyles.styleSemiBold18(context),
          ),
        ),
      ),
    );
  }
}
