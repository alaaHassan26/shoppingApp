import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';

class ShimmerButton extends StatelessWidget {
  const ShimmerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
        height: 48,
        decoration: BoxDecoration(
            color: isDarkMode ? Colors.white38 : Colors.black38,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.white38 : Colors.black38,
            highlightColor: isDarkMode ? Colors.white10 : Colors.black12,
            child: Text(
                AppLocalizations.of(context)!.translate('pleasewaitamoment'),
                style: AppStyles.styleSemiBold20(context)),
          ),
        ));
  }
}
