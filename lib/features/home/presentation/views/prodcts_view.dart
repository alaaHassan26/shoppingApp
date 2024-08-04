import 'package:flutter/material.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/home/presentation/views/widget/prodcts_body.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black12 : const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('home'),
          style: AppStyles.styleSemiBold24(context),
        ),
      ),
      body: const SafeArea(
        child: ProdctsBody(),
      ),
    );
  }
}
