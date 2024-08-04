import 'package:flutter/material.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';

class AccountAndPassword extends StatelessWidget {
  const AccountAndPassword({
    super.key,
    required this.text,
    this.onPressed,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: AppStyles.styleBold16(context),
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward,
              color: colorRed,
            ))
      ],
    );
  }
}
