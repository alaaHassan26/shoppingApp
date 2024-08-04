import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';

class CartButtomItem extends StatelessWidget {
  const CartButtomItem({
    super.key,
    required this.totalAmount,
  });

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.translate('totalamount'),
                style: AppStyles.styleMedium16(context),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: AppStyles.styleMedium20(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // ضع هنا منطق زر "Checkout"
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: FittedBox(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.scaleDown,
              child: Text(
                AppLocalizations.of(context)!.translate('ordercompletion'),
                style: AppStyles.styleBold16(context).copyWith(color: colorRed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
