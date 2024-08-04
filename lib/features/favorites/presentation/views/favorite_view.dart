import 'package:flutter/material.dart';

import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('favorite'),
            style: AppStyles.styleSemiBold24(context)),
      ),
      body: const SafeArea(child: FavoriteBody()),
    );
  }
}
